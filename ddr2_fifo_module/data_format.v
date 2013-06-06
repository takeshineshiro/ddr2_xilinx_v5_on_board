`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:54:39 05/03/2013 
// Design Name: 
// Module Name:    data_format 
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
module data_format_in  # (

   parameter   DI_WIDTH   =  32 ,
   parameter   DO_WIDTH   =  64	



     )(
	  //input
	  
	 input                           clk       ,
    input                           reset     ,
    input [DI_WIDTH-1:0]            data_in   ,
    input                           din_valid ,	
    inout   [35:0]                  CONTROL   ,	 
	//output
	 output [DO_WIDTH-1:0]            dout     ,
    output                           dout_vd                     	 
	 
	
		  
	  
        );



   
    localparam    WIDTH_CH    =   DO_WIDTH/DI_WIDTH   ;



  //wire 
  
 
  //reg  
  
   reg     [DO_WIDTH-1:0]              data_buffer  ;
	
	reg                                 data_valid   ;
	
	
	reg    [WIDTH_CH-1:0]                counter     ;
	
	reg    [DI_WIDTH-1:0]                 buffer     ;
	
	reg    [DI_WIDTH-1:0]                 din_buf   ;
	
	
	
	assign     dout                    =   data_buffer   ;
 
 
	
	  
 //  assign     data_in_reg             =   data_in ;
	
	
	
	

  wire    [97:0]                           trig0   ;
  
  
  assign    trig0[0]                =   din_valid  ;
  
  assign    trig0[1]                =   dout_vd    ;
  
  
  assign   trig0[33:2]              =   data_in   ;

  assign   trig0[97:34]             =    dout     ;
  
  
  
  
  
  

ila_data_format      ila_data_format  (

   .CONTROL(CONTROL),
   .CLK(clk),
   .TRIG0(trig0)






);






   assign       dout_vd    =    data_valid   ;
	
	
	
//	 
//	always@( posedge  clk  or  posedge  reset)
//	
//	begin
//	 
//	   if (reset)
//		  
//		    dout_vd    <=  0  ;
//      else
//		
//		   dout_vd    <= data_valid  ;
//		
//
//	end  
//	
	
	
	always@( posedge  clk  or  posedge  reset)
	
	begin
	 
	   if (reset)
		  
		    din_buf   <=  0  ;
      else
		
		   din_buf   <= data_in  ;
		

	end  
	
	
	
	
	
	
	
	
	
	
	always@( posedge clk   or  posedge  reset  )
	
   begin
   
	   if (reset)
		  begin
		  data_buffer    <=   0; 
		  data_valid     <=   0;
		  counter        <=   WIDTH_CH-1;
		 
		  buffer         <= 0  ;
		  end
	  else 
	    begin
	    if (din_valid)
	    begin
		   
		 
		   if  (counter !=0 )
			 
		          begin
		         data_buffer              <=  {data_buffer[DI_WIDTH-1:0],din_buf}; 
					 
			  
		         data_valid               <=  1'b0 ;
					counter                  <=  counter -1;
				    end
        else
		        begin
				   data_valid               <=  1'b1           ;
					data_buffer              <= {data_buffer[DI_WIDTH-1:0],din_buf}    ;
					counter                  <=  WIDTH_CH-1   ;
				 			  
				  end 
		
	 
		 end
	  
    else
	    begin
		 
		    if (counter!=WIDTH_CH-1)
			 
			   begin
				   data_valid               <=  1'b1           ;
					data_buffer              <=  data_buffer    ;
					counter                  <=  WIDTH_CH-1     ;
				
				
				
				end
			 
		   else
			      begin
		 		 		 
		         data_valid               <=  1'b0         ;
					data_buffer              <=  0            ;
					counter                  <=  WIDTH_CH-1     ; 
				   end
		 
		 end 
		 
	 
	 
	 
	 end



   end 
	
	
	
	
	
	
	
	
	
	
	
	
	
  
  

 

	 











endmodule