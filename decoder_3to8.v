`timescale 1ns / 1ps

// worked on from 9:30am to 10:00am on 10/17/2018

/***************************************************************************
 * File Name: decoder_3to8.v
 * Project: Lab 05, Register Files
 * Designer: Juan Saavedra, Brianna Segura
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: Oct. 17, 2018
 *
 * Purpose: 
 *
 * Notes: 
***************************************************************************/

module decoder_3to8(
    input       [2:0]   in,
    input               en,
    output  reg [7:0]   y
    );
    
    always @(en or in)
        case({en, in})
            4'b1_000    : y = 8'b0000_0001;
            4'b1_001    : y = 8'b0000_0010;
            4'b1_010    : y = 8'b0000_0100;
            4'b1_011    : y = 8'b0000_1000;
            4'b1_100    : y = 8'b0001_0000;
            4'b1_101    : y = 8'b0010_0000;
            4'b1_110    : y = 8'b0100_0000;
            4'b1_111    : y = 8'b1000_0000;
            default     : y = 8'b0000_0000;
        endcase
endmodule
