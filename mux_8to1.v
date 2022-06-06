`timescale 1ns / 1ps

// worked from 9:15am to 9:30am , 10/09/2018
/***************************************************************************
 * File Name: mux_8to1.v
 * Project: Lab 04, Memory and Display Controllers
 * Designer: Juan Saavedra, Brianna Segura
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: October 9th, 2018
 *
 * Purpose: An eight to 1 multiplexor. It takes a 32 bit input d, separates
 * it into groups of four bits (i.e. d[3:0], d[7:4], ... d[31:28]) and selects
 * a four bit nibble based on a 3-bit input select. The selection is made using
 * a case statement where the input value selected using the sel input will be 
 * assigned to the 4-bit Y output.
 * 
 * Notes:  
***************************************************************************/

module mux_8to1(
    input [2:0] sel,
    input [31:0] d,
    output reg [3:0] Y
    );
    
    always @ ( sel or d )
        case ( sel )
            3'b000 : Y = d[3:0]  ;
            3'b001 : Y = d[7:4]  ;
            3'b010 : Y = d[11:8] ;
            3'b011 : Y = d[15:12];
            3'b100 : Y = d[19:16];
            3'b101 : Y = d[23:20];
            3'b110 : Y = d[27:24];
            3'b111 : Y = d[31:28];
            default: Y = 4'b0000 ;
        endcase
    
endmodule
