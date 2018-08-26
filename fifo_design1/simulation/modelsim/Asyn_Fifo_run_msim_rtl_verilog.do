transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Administrator/Desktop/FIFO-design {C:/Users/Administrator/Desktop/FIFO-design/Dul_Ram.v}
vlog -vlog01compat -work work +incdir+C:/Users/Administrator/Desktop/FIFO-design {C:/Users/Administrator/Desktop/FIFO-design/Asyn_Fifo.v}

vlog -vlog01compat -work work +incdir+C:/Users/Administrator/Desktop/FIFO-design/simulation/modelsim {C:/Users/Administrator/Desktop/FIFO-design/simulation/modelsim/Asyn_Fifo.vt}

vsim -t 1ns -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Asyn_Fifo_vlg_tst

do wave1.do
view structure
view signals
run 1ms
