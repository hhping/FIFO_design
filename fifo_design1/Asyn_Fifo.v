//__________________________________________________________________
//
//  Module      :   ASYN_FIFO
//              
//  By          :   Kejie
//  E-mail      :   Kejie1208@126.com
//  Created     :   08/12/10 
//  Read Mode   :   First-Word Fall-Through
//                  All Outputs are Registed
//  First-Word
//  Fall-Through
//  Notes:          The First Word into the fifo will be valid in the w_data,
//                  while the r_empty is fall down.
//                  And if r_re is assigned some time, 
//                  then in the next Cycle 
//                  the w_data will be the Second Word  
//___________________________________________________________________

`timescale 1ns/1ns

module  Asyn_Fifo #(
    
parameter   L=3,        //Fifo Depth = 2^L+2;
parameter   DW=4        //Data Width = DW;
)
(
  
  input                   w_clk,
  input                   w_clr,
                          
  input       [DW-1:0]    w_data,
  input                   w_we,
  output reg              w_full,
  output reg              w_afull,
                          
  input                   r_clr,
  input                   r_clk,
  output reg  [DW-1:0]    r_data,
  input                   r_re,
  output reg              r_empty,
  output reg              r_aempty
);

integer     i,j;

wire  clr=r_clr&w_clr;

reg   [L:0]   wptr;
reg   [L:0]   rptr;
wire  [L:0]   wptr_gw=(wptr>>1) ^ wptr;
wire  [L:0]   rptr_gr=(rptr>>1) ^ rptr;

reg   [L:0]   wptr_gr;
reg   [L:0]   rptr_gw;

reg   [L:0]   wptr_r;
reg   [L:0]   rptr_w;
wire  [L:0]   wptr_nx=wptr+1'h1;
wire  [L:0]   wptr_nnx=wptr+2'h2;
wire  [L:0]   rptr_nx=rptr+1'h1;

//____________________________________________________ wptr_r
always@(*)
  for(i=0;i<=L;i=i+1)
    wptr_r[i]=^(wptr_gr>>i);//gray-code to binary-code
    
//____________________________________________________ rptr_w
always@(*)
  for(j=0;j<=L;j=j+1)
    rptr_w[j]=^(rptr_gw>>j);//gray-code to binary-code
    
//____________________________________________________ wptr_gr
reg  [L:0]  wptr_gw_Q;
always@(posedge w_clk or negedge clr)
if(!clr)              wptr_gw_Q<={{L+1}{1'b0}};
else                  wptr_gw_Q<=wptr_gw;

reg   [L:0]   wptr_gr1;
always@(posedge r_clk or negedge clr)
if(!clr)              wptr_gr1<={{L+1}{1'b0}};
else                  wptr_gr1<=wptr_gw_Q;
always@(posedge r_clk or negedge clr)
if(!clr)              wptr_gr<={{L+1}{1'b0}};
else                  wptr_gr<=wptr_gr1;

//____________________________________________________ rptr_gw

reg   [L:0]   rptr_gr_Q;
always@(posedge r_clk or negedge clr)
if(!clr)              rptr_gr_Q<={{L+1}{1'b0}};
else                  rptr_gr_Q<=rptr_gr;

reg   [L:0]   rptr_gw1;
always@(posedge w_clk or negedge clr)
if(!clr)              rptr_gw1<={{L+1}{1'b0}};
else                  rptr_gw1<=rptr_gr_Q;
always@(posedge w_clk or negedge clr)
if(!clr)              rptr_gw<={{L+1}{1'b0}};
else                  rptr_gw<=rptr_gw1;

//****************** Write Part **********************
//____________________________________________________ full
wire  aafull =!(|(wptr_nnx[L-1:0]^rptr_w[L-1:0]))&(rptr_w[L]^wptr_nnx[L]);
wire  afull =!(|(wptr_nx[L-1:0]^rptr_w[L-1:0]))&(rptr_w[L]^wptr_nx[L]);
wire  full  =!(|(wptr[L-1:0]^rptr_w[L-1:0]))&(rptr_w[L]^wptr[L]);
//wire  aafull =(wptr_nnx[L-1:0]==rptr_w[L-1:0])&(rptr_w[L]!=wptr_nnx[L]);
//wire  afull =(wptr_nx[L-1:0]==rptr_w[L-1:0])&(rptr_w[L]!=wptr_nx[L]);
//wire  full  =(wptr[L-1:0]==rptr_w[L-1:0])&(rptr_w[L]!=wptr[L]);

//____________________________________________________ w_full
always@(posedge w_clk or negedge clr)
if(!clr)              w_full<=1'b0;
else if(afull & w_we )////|full)
                      w_full<=1'b1;
else if(!full)        w_full<=1'b0;

//____________________________________________________ w_afull
always@(posedge w_clk or negedge clr)
if(!clr)              w_afull<=1'b0;
else if(aafull & w_we )////|full)
                      w_afull<=1'b1;
else if(!full&!afull)
                      w_afull<=1'b0;

//____________________________________________________ wptr

always@(posedge w_clk or negedge clr)
if(!clr)              wptr<={{L+1}{1'b0}};
else if(w_we &!full)  wptr<=wptr_nx;

//____________________________________________________ Dul_Ram
wire    [DW-1:0]      Ram_data;
wire                  Ram_rd;
wire                  Load;
wire                  Ram_empty;

Dul_Ram  #(  
      .L        (   L           ),
      .DW       (   DW          )
)
Dul_Ram (
      .ac       (   w_clk       ),
      .aa       (   wptr[L-1:0] ),
      .ad       (   w_data      ),
      .aw       (   w_we&!full  ),
      
      .bc       (   r_clk       ),
      .ba       (   rptr[L-1:0] ),
      .bd       (   Ram_data    ),
      .br       (   Ram_rd      )
);
/*
X_Dul_Ram X_Dul_Ram(//Xilinx Ram Module
      .clka     (   w_clk       ),
      .addra    (   wptr[L-1:0] ),
      .dina     (   w_data      ),
      .wea      (   w_we&!full  ),
      
      .clkb     (   r_clk       ),
      .addrb    (   rptr[L-1:0] ),
      .doutb    (   Ram_data    ),
      .enb      (   Ram_rd      )
      
       );
*/
//******************** Read Part **********************
//____________________________________________________ rptr
always@(posedge r_clk or negedge clr)
if(!clr)              rptr<={{L+1}{1'b0}};
else if(Ram_rd)       rptr<=rptr_nx;

assign Ram_empty  =//wptr_r==rptr;
                  !(|(wptr_r^rptr));


//******************** Fall-Through STATE*************
//____________________________________________________ ST
reg  [3:0]   ST,nST;

parameter     IDLE=2'h0,FRST=2'h1,ONLO=2'h2,HVTW=2'h3;

always@(posedge r_clk or negedge clr)
if(!clr)              ST<=4'b0001;
else                  ST<=nST;

always@(*)
  begin
    nST=4'b000;
    case(1'b1)
      ST[IDLE]:
            if(!Ram_empty)  nST[FRST]=1'b1;
            else            nST[IDLE]=1'b1;            
      ST[FRST]:
            if( Ram_empty)  nST[ONLO]=1'b1;
            else            nST[HVTW]=1'b1;            
      ST[ONLO]:
            if( Ram_empty & r_re )
                            nST[IDLE]=1'b1;
            else if(!Ram_empty & r_re)
                            nST[FRST]=1'b1;
            else if(!Ram_empty &!r_re)
                            nST[HVTW]=1'b1;
            else            nST[ONLO]=1'b1;            
      ST[HVTW]:
            if( Ram_empty & r_re)  
                            nST[ONLO]=1'b1;
            else            nST[HVTW]=1'b1;
    default:                nST[IDLE]=1'b1;
    endcase
  end

//____________________________________________________ Ram_rd
assign   Ram_rd  =(ST[IDLE] |ST[FRST] |
                   ST[ONLO] |ST[HVTW]&r_re) &
                  !Ram_empty;
    
//____________________________________________________ Load
assign  Load=ST[FRST] | ST[HVTW]&r_re;

//____________________________________________________ r_data
always@(posedge r_clk or negedge clr)
if(!clr)                r_data<=6'h0;
else if(Load)           r_data<=Ram_data;

//____________________________________________________ r_empty
always@(posedge r_clk or negedge clr)
if(!clr)              r_empty<=1'b1;
else if(Load)         r_empty<=1'b0;
else if(ST[ONLO] & r_re)
                      r_empty<=1'b1;
//____________________________________________________ r_aempty
always@(posedge r_clk or negedge clr)
if(!clr)              r_aempty<=1'b1;
else if(ST[ONLO] &!Ram_empty &!r_re |
        ST[FRST] &!Ram_empty &!r_re )r_aempty<=1'b0;
else if(ST[HVTW] & Ram_empty & r_re )r_aempty<=1'b1;

endmodule  