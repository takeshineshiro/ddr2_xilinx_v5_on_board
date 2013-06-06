///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Xilinx, Inc.
// All Rights Reserved
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor     : Xilinx
// \   \   \/     Version    : 13.3
//  \   \         Application: Xilinx CORE Generator
//  /   /         Filename   : ila_data_gen.v
// /___/   /\     Timestamp  : Wed Jun 05 14:43:29 �й���׼ʱ�� 2013
// \   \  /  \
//  \___\/\___\
//
// Design Name: Verilog Synthesis Wrapper
///////////////////////////////////////////////////////////////////////////////
// This wrapper is used to integrate with Project Navigator and PlanAhead

`timescale 1ns/1ps

module ila_data_gen(
    CONTROL,
    CLK,
    TRIG0);


inout [35 : 0] CONTROL;
input CLK;
input [90 : 0] TRIG0;

endmodule