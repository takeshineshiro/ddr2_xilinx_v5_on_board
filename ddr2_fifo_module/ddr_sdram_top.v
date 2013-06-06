`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:34:29 06/04/2013 
// Design Name: 
// Module Name:    ddr_sdram_top 
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


module ddr_sdram_top   # (

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
   input                              sys_clk,
   input                              idly_clk_200,
   input                              sys_rst_n,
   output                             phy_init_done,
   output                             rst0_tb,
   output                             clk0_tb,
	inout  [35:0]                      CONTROL,  
   output                             app_wdf_afull,
   output                             app_af_afull,
   output                             rd_data_valid,
   input                              app_wdf_wren,
   input                              app_af_wren,
   input  [30:0]                      app_af_addr,
   input  [2:0]                       app_af_cmd,
   output [(APPDATA_WIDTH)-1:0]                rd_data_fifo_out,
   input  [(APPDATA_WIDTH)-1:0]                app_wdf_data,
   input  [(APPDATA_WIDTH/8)-1:0]              app_wdf_mask_data,
   inout  [DQS_WIDTH-1:0]             ddr2_dqs,
   inout  [DQS_WIDTH-1:0]             ddr2_dqs_n,
   output [CLK_WIDTH-1:0]             ddr2_ck,
   output [CLK_WIDTH-1:0]             ddr2_ck_n
  
  
  
  
  
  
    );







wire        [93:0]                    trig0    ;





  assign    trig0[0]   =     phy_init_done   ;
  
  assign   trig0[1]    =     app_wdf_afull  ;
  
  assign   trig0[2]    =     app_af_afull   ;
  
  assign   trig0[3]    =     rd_data_valid  ;
  
  assign   trig0[4]    =     app_wdf_wren   ;
  
  assign   trig0[5]    =     app_af_wren    ;
  
  assign  trig0[8:6]   =     app_af_cmd     ;
  
  assign  trig0[39:9]   =     app_af_addr   ; 
  
  assign  trig0[93:40]  =     app_wdf_data  ;
  
  
			
  
				
			
			   
		ila_ddr_sdram   	  ila_ddr_sdram  (
		
		
		
		 .CONTROL(CONTROL),
       .CLK(sys_clk),
       .TRIG0(trig0)
		
		
		
		
		
		);
			  







ddr_sdram    # (
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
 

) ddr_sdram   (

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
            .sys_clk(sys_clk),
            .idly_clk_200(idly_clk_200),
				.sys_rst_n(sys_rst_n),
				.phy_init_done(phy_init_done),
				.rst0_tb(rst0_tb),
				.clk0_tb(clk0_tb),
				
				
				.app_wdf_afull(app_wdf_afull),
				.app_af_afull(app_af_afull),
				.rd_data_valid(rd_data_valid),
				.app_wdf_wren(app_wdf_wren),
				.app_af_wren(app_af_wren),
			   .app_af_addr(app_af_addr),
			  	.app_af_cmd(app_af_cmd),
				.rd_data_fifo_out(rd_data_fifo_out),
			   .app_wdf_data(app_wdf_data),
			   .app_wdf_mask_data(app_wdf_mask_data),                                          //  new  add
			   .ddr2_dqs(ddr2_dqs),
				.ddr2_dqs_n(ddr2_dqs_n),
				.ddr2_ck(ddr2_ck),
				.ddr2_ck_n(ddr2_ck_n)
 
 
        );














endmodule
