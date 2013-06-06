`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:42:15 05/08/2013 
// Design Name: 
// Module Name:    sim_fifo_top 
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
module  ddr2_module_top #(

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
   parameter CAS_LAT                 = 3,       
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
   parameter CLK_PERIOD              = 6666,       
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

                                                    // for  the  fifo_top_interface                                         
   // input
	   input   [DATA_WIDTH-1 :0]      data_in     ,
		input                          wr_clk      ,
		input                          ref_clk     ,         // 50M
		input                          sys_clk     ,
		input                          sys_clk_ddr2, 
		input                          clk_200     ,
		input                          rd_clk      ,  
		input                          reset_n     ,
		input                          wr_en       ,
		input                          rd_en       ,
		inout   [35:0]                 CONTROL     ,
		
  // output
     output                           full       ,
     output                           almost_full,
     output	                          empty      ,
     output                           almost_empty,
     output                           phy_init_done,
    
     output                           dout_vd    ,
     output  [DATA_WIDTH-1 :0]        data_out   ,  

 // ddr2_interface
   
	  output       [CLK_WIDTH-1:0]         ddr2_clk,        
     output       [CLK_WIDTH-1:0]         ddr2_clk_n,    
	  output       [CKE_WIDTH-1:0]         ddr2_clk_en,        
	  output       [CS_WIDTH-1:0]          ddr2_cs_n,    
	  output                               ddr2_ras_n,     
	  output                               ddr2_cas_n,  
	  output                               ddr2_we_n,
	  output       [DM_WIDTH-1:0]          ddr2_dm, 
     output       [BANK_WIDTH-1:0]        ddr2_ba,	   
     output       [ROW_WIDTH-1:0]         ddr2_a,       
	  inout        [DQ_WIDTH-1:0]          ddr2_dq,  
     inout        [DQS_WIDTH-1:0]         ddr2_dqs,	      
	  inout        [DQS_WIDTH-1:0]         ddr2_dqs_n,    
     output       [ODT_WIDTH-1:0]         ddr2_odt	    
     	  

    );


      localparam    DEVICE_WIDTH         =   8  ;

  



 //wire
 
   wire   [DQ_WIDTH-1:0]              ddr2_dq_0 ;
   wire   [ROW_WIDTH-1:0]             ddr2_a_0  ;
   wire   [BANK_WIDTH-1:0]            ddr2_ba_0 ;
   wire                               ddr2_ras_n_0;
   wire                               ddr2_cas_n_0;
   wire                               ddr2_we_n_0 ;
   wire   [CS_WIDTH-1:0]              ddr2_cs_n_0 ;
   wire   [ODT_WIDTH-1:0]             ddr2_odt_0;
   wire   [CKE_WIDTH-1:0]             ddr2_cke_0 ;
   wire   [DQS_WIDTH-1:0]             ddr2_dqs_0  ;
   wire   [DQS_WIDTH-1:0]             ddr2_dqs_n_0;
   wire   [CLK_WIDTH-1:0]             ddr2_ck_0 ;
   wire   [CLK_WIDTH-1:0]             ddr2_ck_n_0 ;
	wire   [DM_WIDTH-1:0]              ddr2_dm_fpga_0;
	
	
	wire [DQ_WIDTH-1:0]         		   ddr2_dq_sdram;
   wire [DQS_WIDTH-1:0]         			ddr2_dqs_sdram;
   wire [DQS_WIDTH-1:0]         			ddr2_dqs_n_sdram;
   wire [DM_WIDTH-1:0]               	ddr2_dm_sdram;
	
	
	wire                                ddr2_reset_n;
	
	
 //reg

   reg [DM_WIDTH-1:0]           ddr2_dm_sdram_tmp;
   reg [CLK_WIDTH-1:0]          ddr2_clk_sdram;
   reg [CLK_WIDTH-1:0]          ddr2_clk_n_sdram;
   reg [ROW_WIDTH-1:0]          ddr2_address_sdram;
   reg [BANK_WIDTH-1:0]         ddr2_ba_sdram;
   reg                          ddr2_ras_n_sdram;
   reg                          ddr2_cas_n_sdram;
   reg                          ddr2_we_n_sdram;
   reg [CS_WIDTH-1:0]           ddr2_cs_n_sdram;
   reg [CKE_WIDTH-1:0]          ddr2_cke_sdram;
   reg [ODT_WIDTH-1:0]          ddr2_odt_sdram;
 


   reg [ROW_WIDTH-1:0]           ddr2_address_reg;
   reg [BANK_WIDTH-1:0]          ddr2_ba_reg;
   reg [CKE_WIDTH-1:0]           ddr2_cke_reg;
   reg                           ddr2_ras_n_reg;
   reg                           ddr2_cas_n_reg;
   reg                           ddr2_we_n_reg;
   reg [CS_WIDTH-1:0]            ddr2_cs_n_reg;
   reg [ODT_WIDTH-1:0]           ddr2_odt_reg;	
 
 
 
 














ddr2_fifo_top      # (

            .DATA_WIDTH (DATA_WIDTH),
	         .DO_WIDTH   (DO_WIDTH),	 
            .BANK_WIDTH (BANK_WIDTH),       
                                       // # of memory bank addr bits.
            .CKE_WIDTH  (CKE_WIDTH),       
                                       // # of memory clock enable outputs.
            .CLK_WIDTH  (CLK_WIDTH),       
                                       // # of clock outputs.
            .COL_WIDTH  (COL_WIDTH),       
                                       // # of memory column bits.
            .CS_NUM     (CS_NUM),       
                                       // # of separate memory chip selects.
            .CS_WIDTH   (CS_WIDTH),       
                                       // # of total memory chip selects.
            .CS_BITS    (CS_BITS),       
                                       // set to log2(CS_NUM) (rounded up).
            .DQ_WIDTH   (DQ_WIDTH),       
                                       // # of data width.
            .DQ_PER_DQS (DQ_PER_DQS),       
                                       // # of DQ data bits per strobe.
            .DQS_WIDTH  (DQS_WIDTH),       
                                       // # of DQS strobes.
            .DQ_BITS    (DQ_BITS),       
                                       // set to log2(DQS_WIDTH*DQ_PER_DQS).
            .DQS_BITS   (DQS_BITS),       
                                       // set to log2(DQS_WIDTH).
            .ODT_WIDTH  (ODT_WIDTH),       
                                       // # of memory on-die term enables.
            .ROW_WIDTH  (ROW_WIDTH),       
                                       // # of memory row and # of addr bits.
            .ADDITIVE_LAT(ADDITIVE_LAT),       
                                       // additive write latency.
            .BURST_LEN   (BURST_LEN),       
                                       // burst length (in double words).
            .BURST_TYPE  (BURST_TYPE),       
                                       // burst type (=0 seq; =1 interleaved).
            .CAS_LAT     (CAS_LAT),       
                                       // CAS latency.
            .ECC_ENABLE  (ECC_ENABLE),       
                                       // enable ECC (=1 enable).
            .APPDATA_WIDTH(APPDATA_WIDTH),       
                                       // # of usr read/write data bus bits.
            .MULTI_BANK_EN(MULTI_BANK_EN),       
                                       // Keeps multiple banks open. (= 1 enable).
            .TWO_T_TIME_EN(TWO_T_TIME_EN),       
                                       // 2t timing for unbuffered dimms.
            .ODT_TYPE      (ODT_TYPE),       
                                       // ODT (=0(none),=1(75),=2(150),=3(50)).
            .REDUCE_DRV    (REDUCE_DRV),       
                                       // reduced strength mem I/O (=1 yes).
            .REG_ENABLE    (REG_ENABLE),       
                                       // registered addr/ctrl (=1 yes).
            .TREFI_NS       (TREFI_NS),       
                                       // auto refresh interval (ns).
            .TRAS            (TRAS),       
                                       // active->precharge delay.
            .TRCD            (TRCD),       
                                       // active->read/write delay.
            .TRFC            (TRFC),       
                                       // refresh->refresh, refresh->active delay.
            .TRP             (TRP),       
                                       // precharge->command delay.
            .TRTP            (TRTP),       
                                       // read->precharge delay.
            .TWR              (TWR),       
                                       // used to determine write->precharge.
            .TWTR             (TWTR),       
                                       // write->read delay.
            .HIGH_PERFORMANCE_MODE (HIGH_PERFORMANCE_MODE),       
                              // # = TRUE, the IODELAY performance mode is set
                              // to high.
                              // # = FALSE, the IODELAY performance mode is set
                              // to low.
           .SIM_ONLY          (SIM_ONLY),       
                                       // = 1 to skip SDRAM power up delay.
           .DEBUG_EN           (DEBUG_EN),       
                                       // Enable debug signals/controls.
                                       // When this parameter is changed from 0 to 1,
                                       // make sure to uncomment the coregen commands
                                       // in ise_flow.bat or create_ise.bat files in
                                       // par folder.
           .CLK_PERIOD          (CLK_PERIOD),       
                                       // Core/Memory clock period (in ps).
           .DLL_FREQ_MODE       (DLL_FREQ_MODE),       
                                       // DCM Frequency range.
           .CLK_TYPE            (CLK_TYPE),       
                                       // # = "DIFFERENTIAL " ->; Differential input clocks ,
                                       // # = "SINGLE_ENDED" -> Single ended input clocks.
           .NOCLK200            (NOCLK200),       
                                       // clk200 enable and disable.
           .RST_ACT_LOW         (RST_ACT_LOW)        
	 
 
   )   ddr2_fifo_top  (
	
	                                                    // for  the  fifo_top_interface                                         
   // input
	          .data_in (data_in)  ,
		       .wr_clk  (wr_clk)   ,
		       .ref_clk (ref_clk)  ,         // 50M
				 .sys_clk (sys_clk)  ,
				 .sys_clk_ddr2(sys_clk_ddr2),
				 .clk_200 (clk_200)  ,
		       .rd_clk  (rd_clk)   ,  
		       .reset_n (reset_n)  ,
		       .wr_en   (wr_en)    ,
				 .rd_en   (rd_en)    ,
				 .CONTROL (CONTROL)  ,
		
  // output
             .full   (full)        ,
             .almost_full(almost_full),
             .empty   (empty)      ,
             .almost_empty(almost_empty),
    
             .dout_vd(dout_vd)     ,
             .data_out(data_out)   , 
             .phy_init_done (phy_init_done),       	  
	 	
		
 // for  the  ddr2_interface
            .ddr2_dq(ddr2_dq_0),
            .ddr2_a(ddr2_a_0),
            .ddr2_ba(ddr2_ba_0),
            .ddr2_ras_n(ddr2_ras_n_0),
            .ddr2_cas_n(ddr2_cas_n_0),
            .ddr2_we_n(ddr2_we_n_0),
            .ddr2_cs_n(ddr2_cs_n_0),
            .ddr2_odt(ddr2_odt_0),
            .ddr2_cke(ddr2_cke_0),
            .ddr2_dqs(ddr2_dqs_0),
            .ddr2_dqs_n(ddr2_dqs_n_0),
            .ddr2_ck(ddr2_ck_0),
            .ddr2_ck_n(ddr2_ck_n_0),
				.ddr2_dm(ddr2_dm)
	
		
	
	); 


   
    assign  ddr2_clk               =     ddr2_ck_0;
    assign  ddr2_clk_n             =     ddr2_ck_n_0;
    assign  ddr2_a                 =     ddr2_a_0;
    assign  ddr2_ba                =     ddr2_ba_0;
    assign  ddr2_ras_n             =     ddr2_ras_n_0;
    assign  ddr2_cas_n             =     ddr2_cas_n_0;
    assign  ddr2_we_n              =     ddr2_we_n_0;
    assign  ddr2_cs_n              =     ddr2_cs_n_0;
    assign  ddr2_clk_en            =     ddr2_cke_0;
    assign  ddr2_odt               =     ddr2_odt_0;
 

   assign   ddr2_dq                =     ddr2_dq_0  ;
	assign   ddr2_dqs               =     ddr2_dqs_0 ;
	assign   ddr2_dqs_n             =     ddr2_dqs_n_0; 
	






// =============================================================================
//                             BOARD Parameters
// =============================================================================
// These parameter values can be changed to model varying board delays
// between the Virtex-5 device and the memory model






// Controlling the bi-directional BUS
//  genvar dqwd;
//  generate
//    for (dqwd = 0;dqwd < DQ_WIDTH;dqwd = dqwd+1) begin : dq_delay
//      WireDelay #
//       (
//        .Delay_g     (TPROP_PCB_DATA),
//        .Delay_rd    (TPROP_PCB_DATA_RD)
//       )
//      u_delay_dq
//       (
//        .A           (ddr2_dq_0[dqwd]),
//        .B           (ddr2_dq[dqwd]),
//        .reset       (reset_n)
//       );
//    end
//  endgenerate
//
//
//
//
//  genvar dqswd;
//  generate
//    for (dqswd = 0;dqswd < DQS_WIDTH;dqswd = dqswd+1) begin : dqs_delay
//      WireDelay #
//       (
//        .Delay_g     (TPROP_DQS),
//        .Delay_rd    (TPROP_DQS_RD)
//       )
//      u_delay_dqs
//       (
//        .A           (ddr2_dqs_0[dqswd]),
//        .B           (ddr2_dqs [dqswd]),
//        .reset       (reset_n)
//       );
//
//      WireDelay #
//       (
//        .Delay_g     (TPROP_DQS),
//        .Delay_rd    (TPROP_DQS_RD)
//       )
//      u_delay_dqs_n
//       (
//        .A           (ddr2_dqs_n_0[dqswd]),
//        .B           (ddr2_dqs_n[dqswd]),
//        .reset       (reset_n)
//       );
//    end
//  endgenerate












   




endmodule
