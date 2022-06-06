`timescale 1ns / 1ps

// worked on from 9:15am to 9:30am on 10/17/2018

/***************************************************************************
 * File Name: reg16.v
 * Project: Lab 05, Register Files
 * Designer: Juan Saavedra, Brianna Segura
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: Oct. 17, 2018
 *
 * Purpose: 
 *
 * Notes: 
***************************************************************************/

module reg16(clk, reset, ld, Din, DA, DB, oeA, oeB);

    input           clk, reset, ld, oeA, oeB;
    input   [15:0]  Din;
    output  [15:0]  DA, DB;
    reg     [15:0]  Dout;
    
    // behavioral section for writing to the register
    always @ (posedge clk or posedge reset)
        if (reset)
            Dout <= 16'b0;
        else
            if (ld)
                Dout <= Din;
            else
                Dout <= Dout;
    
    // conditional continuous assignments for reading the register
    assign DA = oeA ? Dout : 16'hz;
    assign DB = oeB ? Dout : 16'hz;

endmodule