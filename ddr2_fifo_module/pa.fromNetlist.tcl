
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name ddr2_fifo_module -dir "D:/ddr2_xilinx_v5/ddr2_fifo_module/planAhead_run_2" -part xc5vlx110tff1136-1
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/ddr2_xilinx_v5/ddr2_fifo_module/ddr2_rtl_top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/ddr2_xilinx_v5/ddr2_fifo_module} {ipcore_dir} }
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
set_param project.pinAheadLayout  yes
set_property target_constrs_file "ddr_sdram.ucf" [current_fileset -constrset]
add_files [list {ddr_sdram.ucf}] -fileset [get_property constrset [current_run]]
open_netlist_design
