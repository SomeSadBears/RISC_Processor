`timescale 1ns / 1ps

/***************************************************************************
 * File Name: pixel_clk.v
 * Project: Lab 04, Memory and Display Controllers
 * Designer: Juan Saavedra
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: Oct. 09, 2018
 *
 * Purpose: A clock divider takes clock_in and reset as inputs. Clock_in is
 * connected to the board's 100MHz clock. This module takes the 100MHz clock
 * input and outputs a slower 500Hz clock via clk_out. The value for the counter
 * is calculated using the formula:
 *          [ (Incoming Frequency / Outgoing Frequency) / 2]
 * In this case our values are:
 *          [ (100Mhz / 480Hz) / 2] = 104,167;
 *
 * Notes: Code obtained from Prof. Allison's CECS 301 Lab 1 Fall 2018 PDF
***************************************************************************/

module pixel_clk(
    input clk_in,
    input reset,
    output reg clk_out
    );
    
    integer i; 
    
//****************************************************************
//  The following verilog code will "divide" and incoming clock
//  by the 32-bit decimal value specified in the "if condition"
//
//  The value of the counter that counts the incoming clock ticks
//  is equal to [ (Incoming Freq / Outgoing Freq) / 2]
//****************************************************************
    
always @(posedge clk_in or posedge reset)
            begin
                if (reset == 1'b1)
                    begin
                        i = 0;
                        clk_out = 0;
                    end
                    // got a clock, so increment the counter and
                    // test to see if half a period has elapsed
                    else
                        begin
                            i = i + 1;
                            if (i >= 104_167)
                                begin
                                    clk_out = ~clk_out;
                                    i = 0;
                                end // if 
                        end // else
                    end // always
    endmodule                           
