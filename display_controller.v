`timescale 1ns / 1ps

// worked on from 10:00am to 10:15am on 10/17/2018
// documented from 1:00pm to 1:30pm on 10/23/2018

/***************************************************************************
 * File Name: display_controller.v
 * Project: Lab 05, Register Files
 * Designer: Juan Saavedra, Brianna Segura
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: Oct. 17, 2018
 *
 * Purpose: This module instantiates one instance of pixel_clk, pixel_controller,
 * mux_8to1, and hex_to_7seg. 
 * The clk input is connected directly to the board's 100MHz clock and used as
 * the clock input for the pixel_clk. The pixel_clk outputs a 480Hz clock which
 * serves as the clock input for the pixel_controller module.
 * The pixel_controller is an autonomous Moore finite state machine with eight
 * states, in addition to the default. The pixel_controller generates the an 
 * 8-bit AN output used to enable each of the eight 7-segment displays one at
 * a time. Simultaneously, the pixel_controller also outputs a 3-bit seg_sel 
 * bus which connects to the mux_8to1 module. 
 * The mux_8to1 module takes a 32-bit bus seg as an input, which is then broken 
 * down into groups of 4-bits (nibbles). The seg_sel bus is used to select 
 * which of the eight nibbles will be passed to the hex_to_7seg
 * via the 4-bit mux_to_hex bus, which connects the mux_8to1 y output to the
 * hex_to_7seg hex_in input. The hex_to_7seg module then translates the
 * 4-bit hex input into its corresponding 7-segment display equivalent, which 
 * is outputed via a 7-bit seg_out bus.
 *
 * Notes: 
***************************************************************************/

module display_controller(
    input           clk,
    input           reset,
    input   [31:0]  seg,
    output  [7:0]   AN,
    output  [6:0]   seg_out
    );
    
    wire        clk_480Hz   ;
    wire [2:0]  seg_sel     ;
    wire [3:0]  mux_to_hex  ;
    
    // module pixel_clk(input clk_in, input reset, output reg clk_out);
    pixel_clk pixel_clk_0(clk, reset, clk_480Hz)                ;
    
    // module pixel_controller(input clk, input reset, 
    // output reg [7:0] AN, output reg [2:0] seg_sel);
    pixel_controller pix_ctrl_0 (clk_480Hz, reset, AN, seg_sel) ;
    
    // module mux_8to1(input [2:0] sel, input [31:0] d, output reg [3:0] Y);
    mux_8to1 mux8to1_0 (seg_sel, seg, mux_to_hex)               ;
    
    // module hex_to_7seg(input [3:0] hex_in, output reg [6:0] seg_out);
    hex_to_7seg hex_to_7seg_0 (mux_to_hex, seg_out)             ;
    
endmodule
