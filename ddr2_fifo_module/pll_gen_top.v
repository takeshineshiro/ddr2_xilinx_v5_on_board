`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:05:46 06/04/2013 
// Design Name: 
// Module Name:    pll_gen_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pll_gen_top(
    
	      input  CLKIN1_IN , 
         input  RST_IN , 
		   inout [35:0] CONTROL,
         output  CLKOUT0_OUT, 
         output  CLKOUT1_OUT, 
         output  CLKOUT2_OUT, 
         output  CLKOUT3_OUT, 
         output  LOCKED_OUT
   

    );


  
  
   



  
  
  




pll_gen    pll_gen  (

                 .CLKIN1_IN(CLKIN1_IN), 
                 .RST_IN(RST_IN), 
                 .CLKOUT0_OUT(CLKOUT0_OUT), 
                 .CLKOUT1_OUT(CLKOUT1_OUT), 
                 .CLKOUT2_OUT(CLKOUT2_OUT), 
                 .CLKOUT3_OUT(CLKOUT3_OUT), 
                 .LOCKED_OUT(LOCKED_OUT)



    );













endmodule
