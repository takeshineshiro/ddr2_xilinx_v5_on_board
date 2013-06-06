
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name ddr2_fifo_module -dir "D:/ddr2_xilinx_v5/ddr2_fifo_module/planAhead_run_1" -part xc5vlx110tff1136-1
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property top ddr2_rtl_top $srcset
set_property target_constrs_file "ddr_sdram.ucf" [current_fileset -constrset]
add_files [list {ipcore_dir/fifo_0.ngc}]
set hdlfile [add_files [list {ddr2_phy_dq_iob.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_phy_dqs_iob.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_phy_dm_iob.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_phy_calib.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_usr_wr.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_usr_rd.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_usr_addr_fifo.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_phy_write.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_phy_io.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_phy_init.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_phy_ctl_io.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_usr_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_phy_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_ctrl.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_mem_if_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/ila_data_gen.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/fifo_1.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/fifo_0.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/fifo.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_infrastructure.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_idelay_ctrl.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_chipscope.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {data_gen.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {cmd_gen.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {addr_gen.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {wr_fifo.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {rd_fifo.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {pll_gen.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/icon_ddr2_rtl.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {fifo_control.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {din_gen.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr_sdram.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {data_format_out.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {data_format.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ddr2_rtl_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
add_files [list {ddr_sdram.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/chipscope_icon.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fifo_0.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/fifo_1.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/icon_ddr2_rtl.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/ila_chipscope_wr_fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/ila_chip_addr_gen.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/ila_chip_clk.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/ila_chip_cmd_gen.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/ila_chip_ddr2_core.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/ila_chip_ddr_sdram.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/ila_chip_rd_fifo.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/ila_data_format_in.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/ila_data_gen.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc5vlx110tff1136-1
