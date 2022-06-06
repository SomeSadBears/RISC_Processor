`timescale 1ns / 1ps

// worked on 11/07/2018 from 12:00pm to 12:30pm

/***************************************************************************
 * File Name: reg_pc.v
 * Project: Lab 07, CPU Execution Unit
 * Designer: Juan Saavedra, Brianna Segura
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: Nov. 6th, 2018
 *
 * Purpose: A generic 16-bit register composed of 16 one-bit D flip flops with
 * some added functionality. When reset is asserted, the output is a 16'b0. 
 * This register possesses a load enable input (ld) as well as an additional input 
 * pc_inc, which is used to implement additonal functionality as defined below:  
 *      ld == 0 & pc_inc == 1   : d_out <= d_out + 16'b1
 *      ld == 1 & pc_inc == 0   : d_out <= d_in
 *      else:                   : d_out <= d_out
 *
 * The above operations take place only on the positive edge of the clock
 * or the positive edge of reset.
 * 
 * Dependencies: None
 *
 * Notes: 
***************************************************************************/

module reg_pc(
    input clk,
    input reset,
    input ld,
    input pc_inc,
    input [15:0] d_in,
    output reg [15:0] d_out
    );
    
    always @ (posedge clk or posedge reset)
        if (reset)
            d_out <= 16'b0;
        else
            case ({ld, pc_inc})
                // 2'b00   : d_out <= d_out     ;
                2'b01   : d_out <= d_out + 16'b1;
                2'b10   : d_out <= d_in         ;
                // 2'b11   : d_out <= d_in + 1  ;
                default : d_out <= d_out        ;
            endcase
endmodule