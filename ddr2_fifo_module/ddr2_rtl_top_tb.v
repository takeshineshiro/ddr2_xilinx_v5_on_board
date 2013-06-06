`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:36:18 05/30/2013
// Design Name:   ddr2_rtl_top
// Module Name:   D:/ddr2_xilinx_v5/ddr2_fifo_module/ddr2_rtl_top_tb.v
// Project Name:  ddr2_fifo_module
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ddr2_rtl_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ddr2_rtl_top_tb;

	// Inputs
	reg clk_in;
	reg reset_n;

	// Outputs
	wire [1:0] ddr2_clk;
	wire [1:0] ddr2_clk_n;
	wire [0:0] ddr2_clk_en;
	wire [1:0] ddr2_cs_n;
	wire ddr2_ras_n;
	wire ddr2_cas_n;
	wire ddr2_we_n;
	wire [3:0] ddr2_dm;
	wire [2:0] ddr2_ba;
	wire [12:0] ddr2_a;
	wire [1:0] ddr2_odt;
	wire [3:0] sys_clk_led;

	// Bidirs
	wire [31:0] ddr2_dq;
	wire [3:0] ddr2_dqs;
	wire [3:0] ddr2_dqs_n;

	// Instantiate the Unit Under Test (UUT)
	ddr2_rtl_top uut (
		.clk_in(clk_in), 
		.reset_n(reset_n), 
		.ddr2_clk(ddr2_clk), 
		.ddr2_clk_n(ddr2_clk_n), 
		.ddr2_clk_en(ddr2_clk_en), 
		.ddr2_cs_n(ddr2_cs_n), 
		.ddr2_ras_n(ddr2_ras_n), 
		.ddr2_cas_n(ddr2_cas_n), 
		.ddr2_we_n(ddr2_we_n), 
		.ddr2_dm(ddr2_dm), 
		.ddr2_ba(ddr2_ba), 
		.ddr2_a(ddr2_a), 
		.ddr2_dq(ddr2_dq), 
		.ddr2_dqs(ddr2_dqs), 
		.ddr2_dqs_n(ddr2_dqs_n), 
		.ddr2_odt(ddr2_odt), 
		.sys_clk_led(sys_clk_led)
	);

	initial begin
		// Initialize Inputs
		clk_in = 0;
		reset_n = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

