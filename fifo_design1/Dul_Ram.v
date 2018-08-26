//__________________________________________________________________
//
//  Module      :   Dul_Ram
//              
//  By          :   Kejie
//  E-mail      :   Kejie1208@126.com
//  Created     :   08/12/10 
//___________________________________________________________________
`timescale 1ns/1ns
module Dul_Ram  #(
  
parameter   L=8,
parameter   DW=6
)
(
  input                     ac,
  input       [L-1:0]         aa,
  input       [DW-1:0]      ad,
  input                     aw,
  
  input                     bc,
  input       [L-1:0]         ba,
  output reg  [DW-1:0]      bd,
  input                     br
);

reg   [DW-1:0] Ram[(1<<L)-1:0]/* synthesis syn_ramstyle="block_ram " */;
//(* ramstyle = "M512" *)reg   [DW-1:0] Ram[(1<<L)-1:0];
always@(posedge ac)
if(aw)  Ram[aa]<=ad;

always@(posedge bc)
if(br)  bd<=Ram[ba];

endmodule