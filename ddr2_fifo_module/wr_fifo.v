`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:08:17 05/06/2013 
// Design Name: 
// Module Name:    wr_fifo 
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
module wr_fifo   # (

   parameter  DATA_WIDTH   = 64 ,  
   parameter  WRITE_BURST  = 8
      )

   (
	
	//input
	  
	 input                               wr_clk  ,
    input                               rd_clk  ,
    input                               reset   ,
    input  	[DATA_WIDTH-1:0]            data_in ,
    input           	                   wr_fifo ,
	 input                               rd_fifo ,
	 inout    [35:0]                     CONTROL ,
	 
	 
//output	
  
	output                               almost_full  ,
   output                               almost_empty ,
   output                               prog_empty,
   output [DATA_WIDTH-1:0]              data_out ,
   output                               dout_vd 	
      
	
	
	
	
    );


//wire

   wire    [134:0]                            trig0    ;
	


//reg

  assign     trig0[0]                  =   wr_fifo     ;
  assign     trig0[1]                  =   rd_fifo     ;
  assign     trig0[2]                  =   almost_full ;
  assign     trig0[3]                  =   almost_empty ;
  assign     trig0[5]                  =   prog_empty  ;
  assign     trig0[6]                  =   dout_vd     ;
  assign     trig0[70:7]               =   data_out    ;
  assign     trig0[134:71]             =   data_in     ; 


  fifo_wr      fifo_wr   (
  
  
     .rst(reset),
     .wr_clk(wr_clk),
     .rd_clk(rd_clk),
     .din(data_in),
     .wr_en(wr_fifo),
     .rd_en(rd_fifo),
     .dout(data_out),
     .full(),
     .almost_full(almost_full),
     .empty(),
     .almost_empty(almost_empty),
     .valid(dout_vd),
     .prog_empty(prog_empty)
  
  
  
  
  
  );






  
 ila_chipscope_wr_fifo     ila_chipscope_wr_fifo (
 
      .CONTROL(CONTROL),
      .CLK(rd_clk),
      .TRIG0(trig0)

 
  );
  
  





















endmodule
