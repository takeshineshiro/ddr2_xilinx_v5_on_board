///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Xilinx, Inc.
// All Rights Reserved
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor     : Xilinx
// \   \   \/     Version    : 13.3
//  \   \         Application: Xilinx CORE Generator
//  /   /         Filename   : ila_chip_ddr_sdram.v
// /___/   /\     Timestamp  : Wed May 29 14:06:23 中国标准时间 2013
// \   \  /  \
//  \___\/\___\
//
// Design Name: Verilog Synthesis Wrapper
///////////////////////////////////////////////////////////////////////////////
// This wrapper is used to integrate with Project Navigator and PlanAhead

`timescale 1ns/1ps

module ila_chip_ddr_sdram(
    CONTROL,
    CLK,
    TRIG0);


inout [35 : 0] CONTROL;
input CLK;
input [96 : 0] TRIG0;

endmodule
