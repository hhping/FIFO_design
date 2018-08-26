onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/w_clk
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/w_clr
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/clr
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/full
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/w_data
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/w_we
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/wptr
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/wptr_nx
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/wptr_r
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/wptr_gr
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/wptr_gw_Q
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/wptr_gr1
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/w_full
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/r_empty
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/r_re
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/w_afull
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/r_clr
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/r_clk
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/r_data
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/r_aempty
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/i
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/j
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/rptr
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/wptr_gw
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/rptr_gr
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/wptr_nnx
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/rptr_gw
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/rptr_w
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/rptr_nx
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/rptr_gr_Q
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/rptr_gw1
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/aafull
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/afull
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/Ram_data
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/Ram_rd
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/Load
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/Ram_empty
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/ST
add wave -noupdate -radix hexadecimal /Asyn_Fifo_vlg_tst/i1/nST
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {348 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {3836 ns}
