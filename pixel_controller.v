`timescale 1ns / 1ps

// worked from 8am to 9am, 10/9/2018

/***************************************************************************
 * File Name: pixel_controller.v
 * Project: Lab 04, Memory and Display Controllers
 * Designer: Juan Saavedra, Brianna Segura
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: October 9th, 2018
 *
 * Purpose: A simple, autonomous Moore finite state machine (always moves to 
 * its next state).  
 * The machine has eight states, in addition to a default state. Each of the
 * eight states outputs an 11-bit binary number, the three least significant
 * bits of the state output are a binary count starting at 000 and increasing 
 * by 1'b1 every state, until reachin 111. These three bits will be used as
 * the select input for the mux_8to1 via the three bit seg_sel output.
 * The most significant eight bits follow a marching zeroes pattern 
 * (starting with 1111_1110, ending with 0111_1111). The upper eight bits
 * are to be directly connected to the board's anodes via the AN output
 * the marching zeroes pattern ensures only one anode will be asserted at a time. 
 * The module is written in such a way that when an anode is asserted, 
 * the mux_8to1 module will receive the appropiate seg_sel signal so that it
 * selects the correct, corresponding input to be passed to the next module 
 * that is, if AN[0] is asserted, seg_sel will indicate mux_8to1 should select
 * the date that ought to be displayed on AN[0].
 * 
 * Notes:  
***************************************************************************/

module pixel_controller(
    input clk,
    input reset,
    output reg [7:0] AN,
    output reg [2:0] seg_sel
    );
    
    // Declare present and next state registers for FSM
    reg [2:0] present_state ;
    reg [2:0] next_state    ;
    
    // Next state combinational logic
    always @( present_state )
        case( { present_state } )
            3'b000 : next_state = 3'b001;
            3'b001 : next_state = 3'b010;
            3'b010 : next_state = 3'b011;
            3'b011 : next_state = 3'b100;
            3'b100 : next_state = 3'b101;
            3'b101 : next_state = 3'b110;
            3'b110 : next_state = 3'b111;
            3'b111 : next_state = 3'b000;
            default: next_state = 3'b000;
        endcase
    
    // State register logic (sequential logic)
    always @( posedge clk or posedge reset )
        if  ( reset == 1'b1 )
            present_state = 3'b000      ;
        else
            present_state = next_state  ;
            
    // Output combinational logic
    always @ (      present_state )
        case ( {    present_state } )
            3'b000 : { AN, seg_sel } = 11'b1111_1110_000;
            3'b001 : { AN, seg_sel } = 11'b1111_1101_001;
            3'b010 : { AN, seg_sel } = 11'b1111_1011_010;
            3'b011 : { AN, seg_sel } = 11'b1111_0111_011;
            3'b100 : { AN, seg_sel } = 11'b1110_1111_100;
            3'b101 : { AN, seg_sel } = 11'b1101_1111_101;
            3'b110 : { AN, seg_sel } = 11'b1011_1111_110;
            3'b111 : { AN, seg_sel } = 11'b0111_1111_111;
            default: { AN, seg_sel } = 11'b1111_1111_000;
        endcase
endmodule
