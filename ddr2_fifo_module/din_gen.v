`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:59:09 05/27/2013 
// Design Name: 
// Module Name:    din_gen 
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
module din_gen(

//input

     input               reset_n  ,
     input               clk      ,
     inout  [35:0]       CONTROL  ,	
	  input               phy_init_done,
    
    
//output
     output    reg          wr_en    ,  
     output                 rd_en    ,
	  output      [31:0]     dout       
	 




    );


    
	  
	 wire      [90:0]                trig0   ;
	
   wire                             buffer ;




     reg     [10:0]            wr_count    ;

    reg      [10:0]            rd_count     ;
    
    reg                        phy_done     ; 



    reg   [12:0]               delay_cnt     ;
	 reg   [12:0]               delay_cnt_rd  ;

    reg                        delay_flag    ;
	 reg                        delay_flag_rd ;
	 
	 reg                       wr_en_buf     ;    
 
    reg                         rd_en_reg0 ;
	 reg                         rd_en_reg1 ;
	 
	 reg                         delay_flag_buf0 ;
	                 
   	 


  
  assign      trig0[0]     =     phy_init_done ;
  
  assign      trig0[1]     =     wr_en ;
  
  assign      trig0[2]     =     rd_en ;
  
  assign      trig0[3]     =     delay_flag ;
  
  assign      trig0[35:4]  =      dout  ;
  
  assign      trig0[48:36]  =     delay_cnt ;
  
  
  assign      trig0[49]     =    phy_done  ;

 
 assign      trig0[62 :50]  =    delay_cnt_rd ;
 
 assign     trig0[63]       =    delay_flag_rd ;

assign      trig0[64]       =    delay_flag_buf0  ;

assign      trig0[65]       =     buffer  ;

    

         

   always@(posedge  clk    or   negedge   reset_n )
   begin
     
     if (!reset_n)
      
          phy_done   <=   0;
     else   if (phy_init_done)
     
          phy_done   <=   1 ;
     
   
   
   
   end 



always@(posedge  clk    or   negedge   reset_n )
   begin
     
     if (!reset_n)
      
		   begin
		
		    delay_flag  <=   0 ;
          delay_cnt   <=   0;
			 end 
     else   if (phy_done) 
	   begin
	       if (delay_cnt <= 511)  
            begin
            delay_cnt   <=   delay_cnt + 1 ;
			   delay_flag  <=   1 ;
             end
         else
	         begin
	          delay_cnt   <=  delay_cnt + 1    ; 
			    delay_flag  <=   0 ;
             end 
       end 
   end 



 //assign      wr_en    =   delay_flag   ;
 
 
   always@(posedge  clk)
	begin
	
	   wr_en    <=   delay_flag    ;
	
	end 
 
 
 
 
 assign      dout     =   delay_cnt     ;







//   always@( posedge  clk    or  negedge   reset_n )
//    
//    begin
//       if (!reset_n)
//     
//           wr_count     <=   0 ;
//      else  if (phy_done &&delay_flag)
//       
//		 begin
//	        if  (wr_count < 1024)
//	   
//		      begin
//            wr_count   <=    wr_count  +1 ;
//			      wr_en   <=    1 ;
//			   end 
//          
//         else  
//			
//            begin
//           
//			  
//				 wr_en     <=    0  ;
//				 
//				 wr_count   <=    wr_count  ;  					
//				 
//            end 
//
//     end 
//
//
//   end 
//
//
//
//
//   always@(posedge  clk )
//	
//	begin
//	 
//	  wr_en_buf   <=   wr_en  ;
//	
//	
//	end 






//always@( posedge  clk    or  negedge   reset_n )
//    
//    begin
//       if (!reset_n)
//              rd_en     <=   0 ;
//      else  if (phy_done&&delay_flag&&(wr_en_buf)&&(!wr_en))
//    
//	   
//        
//            rd_en   <=    1 ;  
//     
//  
// 
//   end 



//  always@( posedge  clk    or  negedge   reset_n )
//    begin
//               rd_en  <=  0 ;
// 
//   end 





//always@(posedge  clk    or   negedge   reset_n )
//   begin
//     
//     if (!reset_n)
//      
//		   begin
//		
//		    delay_flag_rd  <=   0 ;
//          delay_cnt_rd   <=   0;
//			 end 
//     else  if (phy_done&&delay_flag) 
//	     begin
//	        if  (delay_cnt_rd >= 512)  
//            begin
//            delay_cnt_rd   <=   delay_cnt_rd   ;
//			   delay_flag_rd  <=  1 ;
//           end
//          else
//	          begin
//	          delay_cnt_rd   <=  delay_cnt_rd +1  ; 
//			    delay_flag_rd  <=  0  ;
//        
//		        end
//		   end 
//      else
//		    begin
//			     delay_cnt_rd   <=   delay_cnt_rd  ; 
//			    delay_flag_rd  <=    delay_flag_rd  ;
//			 
//			 
//			 end 
//		  
//     end 



   always@( posedge  clk)
	begin
	  
	  delay_flag_buf0  <=   delay_flag   ;     
	
	
	end 


  assign      buffer    =     delay_flag_buf0 && (!delay_flag)  ;


   assign     rd_en     =     delay_flag_rd ? 1:  rd_en    ; 



     always@( posedge  clk  or   negedge   reset_n  )
	begin
	      if  (!reset_n )
			
			      delay_flag_rd    <=  0 ;
	      else    

               delay_flag_rd    <=  buffer  ;
	     
	
	end








//always@(posedge  clk )
//
//begin
//
//  rd_en_reg0   <=      delay_flag_rd  ;
//  
//  rd_en_reg1  <=       rd_en_reg0    ;
// 
//  rd_en        <=     rd_en_reg1    ;
//  
//
//end 
    

 // assign   rd_en    =     delay_flag_rd    ;




// always@( posedge clk   or   negedge  reset_n )
//		 begin
//		    if (!reset_n)	
//            
//           
//				  wr_en     <=  0;
//							
//       else  if (phy_done&&delay_flag )     				
//   	    
//			 
//              wr_en     <=  1;
//
//
//     end
//
// 
//
//
//
//
//
//
//
//
//always@( posedge clk   or   negedge  reset_n )
//		 begin
//		    if (!reset_n)	
//            
//           
//				   dout   <=  0;
//							
//            				
//   	   else if (wr_en)
//           	  dout   <=  dout  +1  ;		
//		   else
//          			
//		        dout  <= dout  ;
//		 
//		 end 








ila_data_gen     ila_data_gen    (

   .CONTROL(CONTROL),
   .CLK(clk),
   .TRIG0(trig0)



);








endmodule
