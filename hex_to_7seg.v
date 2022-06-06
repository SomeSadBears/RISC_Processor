`timescale 1ns / 1ps

/***************************************************************************
 * File Name: hex_to_7seg.v
 * Project: Lab 03, Overlapping Sequence Detector
 * Designer: Juan Saavedra
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: Sep. 30, 2018
 *
 * Purpose: This module takes a 4-bit binary input and outputs the 7-segment
 * equivalent. This is achieved by creating a decoder using a case statement.
 * The case statement takes the value from the 4-bit binary input (hex_in), 
 * the value from hex_in is then matched to the corresponding 7-segment value
 * as follows:
 *      0000: 0;    0001: 1;   0010: 2;   0011: 3;   0100: 4;    0101: 5;
 *      0110: 6;    0111: 7;   1000: 8;   1001: 9;   1010: A;    1011: b;
 *      1100: C;    1101: d;   1110: E;   1111: F    
 *
 * Notes:  
***************************************************************************/

module hex_to_7seg(
    input [3:0] hex_in, 
    output reg [6:0] seg_out
    );
    
    always @( hex_in )
        case (hex_in)
          //4'b____: seg_out =  7'babc_defg;
            4'b0000: seg_out = ~7'b111_1110; // seg_out = 0
            4'b0001: seg_out = ~7'b011_0000; // seg_out = 1
            4'b0010: seg_out = ~7'b110_1101; // seg_out = 2
            4'b0011: seg_out = ~7'b111_1001; // seg_out = 3
            4'b0100: seg_out = ~7'b011_0011; // seg_out = 4
            4'b0101: seg_out = ~7'b101_1011; // seg_out = 5
            4'b0110: seg_out = ~7'b101_1111; // seg_out = 6
            4'b0111: seg_out = ~7'b111_0000; // seg_out = 7
            4'b1000: seg_out = ~7'b111_1111; // seg_out = 8
            4'b1001: seg_out = ~7'b111_1011; // seg_out = 9
            4'b1010: seg_out = ~7'b111_0111; // seg_out = A
            4'b1011: seg_out = ~7'b001_1111; // seg_out = b
            4'b1100: seg_out = ~7'b100_1110; // seg_out = C
            4'b1101: seg_out = ~7'b011_1101; // seg_out = d
            4'b1110: seg_out = ~7'b100_1111; // seg_out = E
            4'b1111: seg_out = ~7'b100_0111; // seg_out = F
            default: seg_out = ~7'b000_0001; // seg_out = -
        endcase   
endmodule
