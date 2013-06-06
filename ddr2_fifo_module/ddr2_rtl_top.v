`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:23 05/27/2013 
// Design Name: 
// Module Name:    ddr2_rtl_top 
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
 module ddr2_rtl_top  #(

   parameter   DATA_WIDTH             = 32 ,
	parameter   DO_WIDTH               = 64 ,
	
	parameter BANK_WIDTH              = 3,       
                                       // # of memory bank addr bits.
   parameter CKE_WIDTH               = 1,       
                                       // # of memory clock enable outputs.
   parameter CLK_WIDTH               = 2,       
                                       // # of clock outputs.
   parameter COL_WIDTH               = 10,       
                                       // # of memory column bits.
   parameter CS_NUM                  = 1,       
                                       // # of separate memory chip selects.
   parameter CS_WIDTH                = 2,       
                                       // # of total memory chip selects.
   parameter CS_BITS                 = 0,       
                                       // set to log2(CS_NUM) (rounded up).
   parameter DM_WIDTH                = 4,       
                                       // # of data mask bits.
   parameter DQ_WIDTH                = 32,       
                                       // # of data width.
   parameter DQ_PER_DQS              = 8,       
                                       // # of DQ data bits per strobe.
   parameter DQS_WIDTH               = 4,       
                                       // # of DQS strobes.
   parameter DQ_BITS                 = 5,       
                                       // set to log2(DQS_WIDTH*DQ_PER_DQS).
   parameter DQS_BITS                = 2,       
                                       // set to log2(DQS_WIDTH).
   parameter ODT_WIDTH               = 2,       
                                       // # of memory on-die term enables.
   parameter ROW_WIDTH               = 13,       
                                       // # of memory row and # of addr bits.
   parameter ADDITIVE_LAT            = 0,       
                                       // additive write latency.
   parameter BURST_LEN               = 8,       
                                       // burst length (in double words).
   parameter BURST_TYPE              = 0,       
                                       // burst type (=0 seq; =1 interleaved).
   parameter CAS_LAT                 = 4,       
                                       // CAS latency.
   parameter ECC_ENABLE              = 0,       
                                       // enable ECC (=1 enable).
   parameter APPDATA_WIDTH           = 64,       
                                       // # of usr read/write data bus bits.
   parameter MULTI_BANK_EN           = 1,       
                                       // Keeps multiple banks open. (= 1 enable).
   parameter TWO_T_TIME_EN           = 0,       
                                       // 2t timing for unbuffered dimms.
   parameter ODT_TYPE                = 1,       
                                       // ODT (=0(none),=1(75),=2(150),=3(50)).
   parameter REDUCE_DRV              = 0,       
                                       // reduced strength mem I/O (=1 yes).
   parameter REG_ENABLE              = 0,       
                                       // registered addr/ctrl (=1 yes).
   parameter TREFI_NS                = 7800,       
                                       // auto refresh interval (ns).
   parameter TRAS                    = 40000,       
                                       // active->precharge delay.
   parameter TRCD                    = 15000,       
                                       // active->read/write delay.
   parameter TRFC                    = 127500,       
                                       // refresh->refresh, refresh->active delay.
   parameter TRP                     = 15000,       
                                       // precharge->command delay.
   parameter TRTP                    = 7500,       
                                       // read->precharge delay.
   parameter TWR                     = 15000,       
                                       // used to determine write->precharge.
   parameter TWTR                    = 7500,       
                                       // write->read delay.
   parameter HIGH_PERFORMANCE_MODE   = "TRUE",       
                              // # = TRUE, the IODELAY performance mode is set
                              // to high.
                              // # = FALSE, the IODELAY performance mode is set
                              // to low.
   parameter SIM_ONLY                = 0,       
                                       // = 1 to skip SDRAM power up delay.
   parameter DEBUG_EN                = 0,       
                                       // Enable debug signals/controls.
                                       // When this parameter is changed from 0 to 1,
                                       // make sure to uncomment the coregen commands
                                       // in ise_flow.bat or create_ise.bat files in
                                       // par folder.
   parameter CLK_PERIOD              = 8000,       
                                       // Core/Memory clock period (in ps).
   parameter DLL_FREQ_MODE           = "HIGH",       
                                       // DCM Frequency range.
   parameter CLK_TYPE                = "SINGLE_ENDED",       
                                       // # = "DIFFERENTIAL " ->; Differential input clocks ,
                                       // # = "SINGLE_ENDED" -> Single ended input clocks.
   parameter NOCLK200                = 0,       
                                       // clk200 enable and disable.
   parameter RST_ACT_LOW             = 1        
                                       // =1 for active low reset, =0 for active high.


)(

  // input
   
	input                                      clk_in ,
	
	
	
	
  
  
  
  
//output
    




  

//ddr2_interface
   inout  [DQ_WIDTH-1:0]              ddr2_dq,
   output [ROW_WIDTH-1:0]             ddr2_a,
   output [BANK_WIDTH-1:0]            ddr2_ba,
   output                             ddr2_ras_n,
   output                             ddr2_cas_n,
   output                             ddr2_we_n,
   output [CS_WIDTH-1:0]              ddr2_cs_n,
   output [ODT_WIDTH-1:0]             ddr2_odt,
   output [CKE_WIDTH-1:0]             ddr2_cke,
   output [DM_WIDTH-1:0]              ddr2_dm,
  
   inout  [DQS_WIDTH-1:0]             ddr2_dqs,
   inout  [DQS_WIDTH-1:0]             ddr2_dqs_n,
   output [CLK_WIDTH-1:0]             ddr2_ck,
   output [CLK_WIDTH-1:0]             ddr2_ck_n,
  
  
  
     

//led

     output  reg [3:0]                   sys_clk_led
	  



    );


  

   



   //wire
	
	
   wire                           clk_50   ;
   wire                           clk_100  ;
   wire	                         clk_125  ;
 	wire                           clk_200  ;
	wire                           clk_buf_125 ;
	wire                           clk_buf_200 ;
	wire                           clk_i_buf_200;
	wire                           clk_i_buf_125;
	wire                           locked   ;

	
	wire                           phy_init_done_reg ;
	
	wire                           wr_en    ;
	wire                           rd_en    ;
	
	wire    [31:0]                  data_in ;
   
               

  
	wire    [35 : 0]                CONTROL0 ;

  
  
  wire     [3:0]                   trig0   ;  



//new

 
  
  reg                                          soft_rst_n    ;     
  
  
  
  
  

           
	       
	 
 wire   [DO_WIDTH-1:0]                           din_fifo    ;
 wire                                            din_fifo_vd ;      
 wire                                            wr_fifo_rd  ;              
	           
 wire                                            almost_full_wr  ;
 wire                                            almost_empty_wr ;
 wire                                            prog_full_wr    ;
 wire                                            prog_empty_wr   ;
 wire   [DO_WIDTH-1:0]                            wr_fifo_out  ;
 wire                                             wr_fifo_vd   ;	               
 wire                                            app_wdf_afull;
 wire                                            app_af_afull ;	            

 
 wire                                            app_wdf_wren ;
 wire                                            app_af_wren  ;
 wire  [30:0]                                    app_af_addr  ;
 wire  [2:0]                                     app_af_cmd   ;
 wire   [(APPDATA_WIDTH)-1:0]                    app_wdf_data ;
	            
 wire                                            rd_data_valid    ;
 wire [(APPDATA_WIDTH)-1:0]                      rd_data_fifo_out ;
 wire [(APPDATA_WIDTH)-1:0]                      rd_fifo_out      ;
 wire                                            fifo_out_vd      ;              	      
	            
 wire    [31:0]                                  data_out     ;
 wire                                            dout_vd    	;

 wire      [35:0]                                CONTROL      ;

 wire                                            clk_out        ;

wire                                             empty_clk_fifo ;

wire                                             phy_init_done_vd  ; 
  
wire                                             empty_fifo_clk  ;

wire                                             phy_done_rd     ;


wire                                             rst0_tb        ;
wire   				                                clk0_tb        ;
   
// 	assign           soft_rst_n    =   (!reset_n)?   0:  (locked  ?   1: soft_rst_n )  ;
	
	
	
	
   reg     [31:0 ]                                 clk0_cnt    ;
	
	reg                                               reset     ;

   
//    always@( posedge clk_in   or   negedge reset_n )
//    begin
//   
//       if  (!reset_n)
//              soft_rst_n   <=  0 ;
//				  
//      else if (locked)
//       
//           soft_rst_n   <=  1   ; 
//	   else
//     
//          soft_rst_n   <=  soft_rst_n  ;
//   end 
   
   
   
   
   
reg                                            phy_init_done_reg_0 ;
reg                                            phy_init_done_reg_1 ;









fifo_clk          fifo_clk   (
     
       .rst(!locked),
       .wr_clk(clk0_tb),
       .rd_clk(clk0_125),
       .din(phy_init_done_reg),
       .wr_en(phy_init_done_reg),
       .rd_en(!empty_fifo_clk),
       .dout(phy_done_rd),
       .full(),
       .empty(empty_fifo_clk),
       .valid()
   
);




    icon_ddr2_rtl       icon_ddr2_rtl  (
	 
	 
	    .CONTROL0(CONTROL)
	 
	 
	 );



 
  


   always@(  posedge  clk0_tb    or  posedge  reset )
	
	begin
	
	   if ( reset )
		
		         sys_clk_led   <=   4'b0000 ;
					
	 else   if (rd_data_valid)
	
	           sys_clk_led   <=   4'b1010  ; 
	

	
	end 

















    pll_gen       pll_gen    (
   
                   .CLKIN1_IN(clk_in), 
                   .RST_IN(1'b0), 
                   .CLKOUT0_OUT(clk_50), 
                   .CLKOUT1_OUT(clk_100), 
                   .CLKOUT2_OUT(clk_125), 
                   .CLKOUT3_OUT(clk_200), 
                   .LOCKED_OUT(locked)
 
   );


// pll_gen_top    pll_gen_top (
// 
//                 .CLKIN1_IN(clk_in), 
//                 .RST_IN(1'b0), 
//					  .CONTROL(CONTROL),
//                 .CLKOUT0_OUT(clk_50), 
//                 .CLKOUT1_OUT(clk_100), 
//                 .CLKOUT2_OUT(clk_125), 
//                 .CLKOUT3_OUT(clk_200), 
//                 .LOCKED_OUT()
// 
 
 
//    ) ;




 //     assign        reset    =     (!locked)  ?  1: ((rst0_tb)? 1:0)   ;


    always@(posedge  clk_125 )
	 
	 begin
	 
      if (!locked )
		 
 	       reset   <=   1  ;
		 else	 if (rst0_tb)	 
		    reset   <=   1  ;
	    else
		 
		   reset   <=   0   ;
			  
	 
	 end 







 din_gen         din_gen   (
 
 //input
      . reset_n (!reset),
      . clk (clk0_tb),
      .CONTROL(),
		.phy_init_done(phy_init_done_reg),
      		
 
 //output
 
     .wr_en (wr_en),
	  .rd_en (rd_en),
	  .dout  (data_in)
 
 
   );




  







 


data_format_in    #(
	    
		   .DI_WIDTH(DATA_WIDTH),
	      .DO_WIDTH(DO_WIDTH)
	 
	 
	 
	    )  data_format_in  (
	
	  //input
	        .clk (clk0_tb),
	        .reset(reset),
			  .data_in(data_in),
	        .din_valid(wr_en),
			  .CONTROL(),
			    
	//output
	      .dout (din_fifo),
		   .dout_vd(din_fifo_vd)
			  	
	
	) ;








wr_fifo    # (
         .DATA_WIDTH(DO_WIDTH),
			.WRITE_BURST (BURST_LEN)
      
  
        )   wr_fifo_module    (
	

  // input	
		  .wr_clk  (clk0_tb),
		  .rd_clk  (clk0_tb),
		  .reset   (reset),
		  .data_in (din_fifo),
		  .wr_fifo (din_fifo_vd),
		  .rd_fifo (wr_fifo_rd),
        .CONTROL (), 		  
		  
//output	
      
	    .almost_full  (almost_full_wr)  ,
       .almost_empty (almost_empty_wr) ,
       .prog_empty   (prog_empty_wr),
       .data_out     ( wr_fifo_out) ,
	    .dout_vd      ( wr_fifo_vd)
		  
		  
		  ) ;  







fifo_control   # (
      .DATA_WIDTH(DO_WIDTH),
      .WRITE_BURST(BURST_LEN),
		.COL_WIDTH(COL_WIDTH) ,
      .ROW_WIDTH(ROW_WIDTH),
      .BANK_WIDTH(BANK_WIDTH)  
 
 
 )  fifo_control  (
 
 //input
     .sys_clk      (clk0_tb ),
     .reset        (reset),
     .data_in_vd   (din_fifo_vd),
	   .almost_full  (almost_full_wr)  ,
     .almost_empty (almost_empty_wr) ,
     .prog_empty   (prog_empty_wr),
     .phy_init_done(phy_init_done_reg),
	  .CONTROL       (),
	   
	   
     .app_wdf_afull(app_wdf_afull),
     .app_af_afull (app_af_afull),
     .rd_en        (rd_en),
     .wr_fifo_in   (wr_fifo_out),
     .wr_fifo_vd   (wr_fifo_vd),	  
 
 
 //output
 
    .wr_fifo_rd (wr_fifo_rd),
 
   .app_wdf_wren(app_wdf_wren),
   .app_af_wren(app_af_wren),
   .app_af_addr(app_af_addr),
   .app_af_cmd(app_af_cmd) ,
 
   .app_wdf_data(app_wdf_data)
	
  

 
 );












 rd_fifo   # (  
	      .DATA_WIDTH(DO_WIDTH),
			.WRITE_BURST (BURST_LEN)
	 
	 
	 )  rd_fifo_module(
	
// input	
	   .wr_clk 		(clk0_tb),
		.rd_clk 		(clk0_tb),
		.reset      (reset),
		.rd_fifo_in (rd_data_fifo_out),
		.rd_fifo_vd	(rd_data_valid),
		.rd_en 		(rd_en),
		.CONTROL    (),
		
 //output
      .full        (),
		.almost_full () ,
      .empty       (),
	   .almost_empty (),
      .rd_fifo_out (rd_fifo_out),
		.fifo_out_vd (fifo_out_vd)
		
	 
	 
	 
	 );







data_format_out    # (
	
	   .DI_WIDTH (DO_WIDTH),
		.DO_WIDTH (DATA_WIDTH)
	
	
	
	  ) data_format_out (
	  
//input
       .clk    (clk0_tb),
		 .reset  (reset),
		 .data_in(rd_fifo_out),
		 .din_vd (fifo_out_vd),
		 .CONTROL(CONTROL),
//output
   	.data_out(data_out),
      .dout_vd (dout_vd)		
	  	  
	  
	  );

















 ddr_sdram_top   #  (
 
            .BANK_WIDTH(BANK_WIDTH),       
                                       // # of memory bank addr bits.
            .CKE_WIDTH(CKE_WIDTH),       
                                       // # of memory clock enable outputs.
            .CLK_WIDTH(CLK_WIDTH),       
                                       // # of clock outputs.
            .COL_WIDTH(COL_WIDTH),       
                                       // # of memory column bits.
            .CS_NUM(CS_NUM),       
                                       // # of separate memory chip selects.
            .CS_WIDTH(CS_WIDTH),       
                                       // # of total memory chip selects.
            .CS_BITS(CS_BITS),       
                                       // set to log2(CS_NUM) (rounded up).
            .DM_WIDTH(DM_WIDTH),       
                                       // # of data mask bits.
            .DQ_WIDTH(DQ_WIDTH),       
                                       // # of data width.
            .DQ_PER_DQS(DQ_PER_DQS),       
                                       // # of DQ data bits per strobe.
            .DQS_WIDTH(DQS_WIDTH),       
                                       // # of DQS strobes.
            .DQ_BITS(DQ_BITS),       
                                       // set to log2(DQS_WIDTH*DQ_PER_DQS).
            .DQS_BITS(DQS_BITS),       
                                       // set to log2(DQS_WIDTH).
            .ODT_WIDTH(ODT_WIDTH),       
                                       // # of memory on-die term enables.
            .ROW_WIDTH(ROW_WIDTH),       
                                       // # of memory row and # of addr bits.
            .ADDITIVE_LAT(ADDITIVE_LAT),       
                                       // additive write latency.
            .BURST_LEN(BURST_LEN),       
                                       // burst length (in double words).
            .BURST_TYPE(BURST_TYPE),       
                                       // burst type (=0 seq; =1 interleaved).
            .CAS_LAT(CAS_LAT),       
                                       // CAS latency.
            .ECC_ENABLE(ECC_ENABLE),       
                                       // enable ECC (=1 enable).
            .APPDATA_WIDTH(APPDATA_WIDTH),       
                                       // # of usr read/write data bus bits.
            .MULTI_BANK_EN(MULTI_BANK_EN),       
                                       // Keeps multiple banks open. (= 1 enable).
            .TWO_T_TIME_EN(TWO_T_TIME_EN),       
                                       // 2t timing for unbuffered dimms.
			    	.ODT_TYPE(ODT_TYPE),       
                                       // ODT (=0(none),=1(75),=2(150),=3(50)).
            .REDUCE_DRV(REDUCE_DRV),       
                                       // reduced strength mem I/O (=1 yes).
            .REG_ENABLE(REG_ENABLE),       
                                       // registered addr/ctrl (=1 yes).
            .TREFI_NS(TREFI_NS),       
                                       // auto refresh interval (ns).
            .TRAS(TRAS),       
                                       // active->precharge delay.
            .TRCD(TRCD) ,                        
                                       // active->read/write delay.
            .TRFC(TRFC),       
                                       // refresh->refresh, refresh->active delay.
            .TRP(TRP),       
                                       // precharge->command delay.
            .TRTP(TRTP),       
                                       // read->precharge delay.
            .TWR(TWR),       
                                       // used to determine write->precharge.
            .TWTR(TWTR),       
                                       // write->read delay.
            .HIGH_PERFORMANCE_MODE(HIGH_PERFORMANCE_MODE),       
                              // # = TRUE, the IODELAY performance mode is set
                              // to high.
                              // # = FALSE, the IODELAY performance mode is set
                              // to low.
            .SIM_ONLY(SIM_ONLY),       
                                       // = 1 to skip SDRAM power up delay.
            .DEBUG_EN(DEBUG_EN),       
                                       // Enable debug signals/controls.
                                       // When this parameter is changed from 0 to 1,
                                       // make sure to uncomment the coregen commands
                                       // in ise_flow.bat or create_ise.bat files in
                                       // par folder.
            .CLK_PERIOD(CLK_PERIOD),       
                                       // Core/Memory clock period (in ps).
            .DLL_FREQ_MODE(DLL_FREQ_MODE),       
                
                                       // DCM Frequency range.
            .CLK_TYPE (CLK_TYPE),       
                                       // # = "DIFFERENTIAL " ->; Differential input clocks ,
                                       // # = "SINGLE_ENDED" -> Single ended input clocks.
            .NOCLK200(NOCLK200),       
                                       // clk200 enable and disable.
            .RST_ACT_LOW(RST_ACT_LOW)       
                                       // =1 for active low reset, =0 for active high.
 
 
 
 )  ddr_sdram_top (
 
            .ddr2_dq(ddr2_dq),
            .ddr2_a(ddr2_a),
            .ddr2_ba(ddr2_ba),
            .ddr2_ras_n(ddr2_ras_n),
            .ddr2_cas_n(ddr2_cas_n),
            .ddr2_we_n(ddr2_we_n),
            .ddr2_cs_n(ddr2_cs_n),
            .ddr2_odt(ddr2_odt),
            .ddr2_cke(ddr2_cke),
            .ddr2_dm(ddr2_dm),                      //  new   add  
            .sys_clk(clk_125),
            .idly_clk_200(clk_200),
				.sys_rst_n(locked),
				.phy_init_done(phy_init_done_reg),
				.rst0_tb(rst0_tb),
				.clk0_tb(clk0_tb),
				.CONTROL(),
				
				.app_wdf_afull(app_wdf_afull),
				.app_af_afull(app_af_afull),
				.rd_data_valid(rd_data_valid),
				.app_wdf_wren(app_wdf_wren),
				.app_af_wren(app_af_wren),
			   .app_af_addr(app_af_addr),
			  	.app_af_cmd(app_af_cmd),
				.rd_data_fifo_out(rd_data_fifo_out),
			   .app_wdf_data(app_wdf_data),
			   .app_wdf_mask_data(0),                                          //  new  add
			   .ddr2_dqs(ddr2_dqs),
				.ddr2_dqs_n(ddr2_dqs_n),
				.ddr2_ck(ddr2_ck),
				.ddr2_ck_n(ddr2_ck_n)
 
 
 
 
 
 
 
 );













//ddr_sdram #
//  (
//            .BANK_WIDTH(BANK_WIDTH),       
//                                       // # of memory bank addr bits.
//            .CKE_WIDTH(CKE_WIDTH),       
//                                       // # of memory clock enable outputs.
//            .CLK_WIDTH(CLK_WIDTH),       
//                                       // # of clock outputs.
//            .COL_WIDTH(COL_WIDTH),       
//                                       // # of memory column bits.
//            .CS_NUM(CS_NUM),       
//                                       // # of separate memory chip selects.
//            .CS_WIDTH(CS_WIDTH),       
//                                       // # of total memory chip selects.
//            .CS_BITS(CS_BITS),       
//                                       // set to log2(CS_NUM) (rounded up).
//            .DM_WIDTH(DM_WIDTH),       
//                                       // # of data mask bits.
//            .DQ_WIDTH(DQ_WIDTH),       
//                                       // # of data width.
//            .DQ_PER_DQS(DQ_PER_DQS),       
//                                       // # of DQ data bits per strobe.
//            .DQS_WIDTH(DQS_WIDTH),       
//                                       // # of DQS strobes.
//            .DQ_BITS(DQ_BITS),       
//                                       // set to log2(DQS_WIDTH*DQ_PER_DQS).
//            .DQS_BITS(DQS_BITS),       
//                                       // set to log2(DQS_WIDTH).
//            .ODT_WIDTH(ODT_WIDTH),       
//                                       // # of memory on-die term enables.
//            .ROW_WIDTH(ROW_WIDTH),       
//                                       // # of memory row and # of addr bits.
//            .ADDITIVE_LAT(ADDITIVE_LAT),       
//                                       // additive write latency.
//            .BURST_LEN(BURST_LEN),       
//                                       // burst length (in double words).
//            .BURST_TYPE(BURST_TYPE),       
//                                       // burst type (=0 seq; =1 interleaved).
//            .CAS_LAT(CAS_LAT),       
//                                       // CAS latency.
//            .ECC_ENABLE(ECC_ENABLE),       
//                                       // enable ECC (=1 enable).
//            .APPDATA_WIDTH(APPDATA_WIDTH),       
//                                       // # of usr read/write data bus bits.
//            .MULTI_BANK_EN(MULTI_BANK_EN),       
//                                       // Keeps multiple banks open. (= 1 enable).
//            .TWO_T_TIME_EN(TWO_T_TIME_EN),       
//                                       // 2t timing for unbuffered dimms.
//			    	.ODT_TYPE(ODT_TYPE),       
//                                       // ODT (=0(none),=1(75),=2(150),=3(50)).
//            .REDUCE_DRV(REDUCE_DRV),       
//                                       // reduced strength mem I/O (=1 yes).
//            .REG_ENABLE(REG_ENABLE),       
//                                       // registered addr/ctrl (=1 yes).
//            .TREFI_NS(TREFI_NS),       
//                                       // auto refresh interval (ns).
//            .TRAS(TRAS),       
//                                       // active->precharge delay.
//            .TRCD(TRCD) ,                        
//                                       // active->read/write delay.
//            .TRFC(TRFC),       
//                                       // refresh->refresh, refresh->active delay.
//            .TRP(TRP),       
//                                       // precharge->command delay.
//            .TRTP(TRTP),       
//                                       // read->precharge delay.
//            .TWR(TWR),       
//                                       // used to determine write->precharge.
//            .TWTR(TWTR),       
//                                       // write->read delay.
//            .HIGH_PERFORMANCE_MODE(HIGH_PERFORMANCE_MODE),       
//                              // # = TRUE, the IODELAY performance mode is set
//                              // to high.
//                              // # = FALSE, the IODELAY performance mode is set
//                              // to low.
//            .SIM_ONLY(SIM_ONLY),       
//                                       // = 1 to skip SDRAM power up delay.
//            .DEBUG_EN(DEBUG_EN),       
//                                       // Enable debug signals/controls.
//                                       // When this parameter is changed from 0 to 1,
//                                       // make sure to uncomment the coregen commands
//                                       // in ise_flow.bat or create_ise.bat files in
//                                       // par folder.
//            .CLK_PERIOD(CLK_PERIOD),       
//                                       // Core/Memory clock period (in ps).
//            .DLL_FREQ_MODE(DLL_FREQ_MODE),       
//                
//                                       // DCM Frequency range.
//            .CLK_TYPE (CLK_TYPE),       
//                                       // # = "DIFFERENTIAL " ->; Differential input clocks ,
//                                       // # = "SINGLE_ENDED" -> Single ended input clocks.
//            .NOCLK200(NOCLK200),       
//                                       // clk200 enable and disable.
//            .RST_ACT_LOW(RST_ACT_LOW)       
//                                       // =1 for active low reset, =0 for active high.
//   )  ddr_sdram  (
//	
//            .ddr2_dq(ddr2_dq),
//            .ddr2_a(ddr2_a),
//            .ddr2_ba(ddr2_ba),
//            .ddr2_ras_n(ddr2_ras_n),
//            .ddr2_cas_n(ddr2_cas_n),
//            .ddr2_we_n(ddr2_we_n),
//            .ddr2_cs_n(ddr2_cs_n),
//            .ddr2_odt(ddr2_odt),
//            .ddr2_cke(ddr2_cke),
//            .ddr2_dm(ddr2_dm),                      //  new   add  
//            .sys_clk(clk_125),
//            .idly_clk_200(clk_200),
//				.sys_rst_n(locked),
//				.phy_init_done(phy_init_done_reg),
//				.rst0_tb(rst0_tb),
//				.clk0_tb(clk0_tb),
//				
//				.app_wdf_afull(app_wdf_afull),
//				.app_af_afull(app_af_afull),
//				.rd_data_valid(rd_data_valid),
//				.app_wdf_wren(app_wdf_wren),
//				.app_af_wren(app_af_wren),
//			   .app_af_addr(app_af_addr),
//			  	.app_af_cmd(app_af_cmd),
//				.rd_data_fifo_out(rd_data_fifo_out),
//			   .app_wdf_data(app_wdf_data),
//			   .app_wdf_mask_data(0),                                          //  new  add
//			   .ddr2_dqs(ddr2_dqs),
//				.ddr2_dqs_n(ddr2_dqs_n),
//				.ddr2_ck(ddr2_ck),
//				.ddr2_ck_n(ddr2_ck_n)
//				
//			
//							
//				
//   );
//               	       
//          








endmodule
