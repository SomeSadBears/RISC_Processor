`timescale 1ns / 1ps

// worked on from 1:00pm to 1:30pm on 10/21/2018

/***************************************************************************
 * File Name: register_file.v
 * Project: Lab 05, Register Files
 * Designer: Juan Saavedra, Brianna Segura
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: Oct. 21, 2018
 *
 * Purpose: 
 *
 * Notes: 
***************************************************************************/

module register_file(
    input           clk,
    input           reset,
    input   [2:0]   W_Adr,
    input   [2:0]   R_Adr,
    input   [2:0]   S_Adr,
    input           we,
    input   [15:0]  W,
    output  [15:0]  DA,
    output  [15:0]  DB
    );
    
    wire    [7:0]   load;
    wire    [7:0]   oeA;
    wire    [7:0]   oeB;    
        
    // module reg16(clk, reset, ld, Din, DA, DB, oeA, oeB);
    reg16 reg0 (clk, reset, load[0], W, DA, DB, oeA[0], oeB[0]);
    reg16 reg1 (clk, reset, load[1], W, DA, DB, oeA[1], oeB[1]);
    reg16 reg2 (clk, reset, load[2], W, DA, DB, oeA[2], oeB[2]);
    reg16 reg3 (clk, reset, load[3], W, DA, DB, oeA[3], oeB[3]);
    reg16 reg4 (clk, reset, load[4], W, DA, DB, oeA[4], oeB[4]);
    reg16 reg5 (clk, reset, load[5], W, DA, DB, oeA[5], oeB[5]);
    reg16 reg6 (clk, reset, load[6], W, DA, DB, oeA[6], oeB[6]);
    reg16 reg7 (clk, reset, load[7], W, DA, DB, oeA[7], oeB[7]);
        
    // module decoder_3to8(input [2:0] in, input en, output reg [7:0] y);
    decoder_3to8 dec_W_Adr(W_Adr, we    ,   load)       ;
    decoder_3to8 dec_R_Adr(R_Adr, (1'b1),   oeA )       ;
    decoder_3to8 dec_S_Adr(S_Adr, (1'b1),   oeB )       ;
    
endmodule
