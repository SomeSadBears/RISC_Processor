`timescale 1ns / 1ps

/***************************************************************************
 * File Name: debouncer.v
 * Project: Lab 03, Overlapping Sequence Detector
 * Designer: Juan Saavedra
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: Sep. 30, 2018
 *
 * Purpose: This debouncer takes an D_in input signal from a switch and outputs 
 * a one-shot signal via D_out once the input signal stabilizes. 
 * To achieve this, this module waits for the stabilization of the bouncing 
 * electro-mechanical switch for 20ms and generates a one-shot output once 
 * the input signal from the switch becomes stable.
 * The check for input stability is achieved by the module taking a 10-bit 
 * sample from the D_in input.  On the positive edge of the clock, sample is 
 * placed on 10 1-bit registers (q9 to q0). 
 * On each positive edge of the clock, the new data flowing in through D_in 
 * is placed on the lowest registry (q0) and the contents of all ten registers 
 * are shifted left (q1 <= q0; q0 <= D_in, etc).
 * The contents of the registers are compared to each other using the "&" 
 * operator. The results of this check are assigned to D_out so that the output
 * will only be 1 if all registers except the first one are 1.
 *
 * Notes: Code obtained from Prof. Allison's CECS 301 Lab 1 Fall 2018 PDF
***************************************************************************/

module debouncer(
    input D_in,
    input clk_in,
    input reset,
    output D_out
    );
    
    //The following template provides a one-shot pulse
    //from a non-clock input (D_in)
    //  input D_in, clk_in, reset;
    //  output D_out;
    //  wire D_out;
    
    // create ten 1-bit registers used to hold sample
    reg q9, q8, q7, q6, q5, q4, q3, q2, q1, q0;
    
    
    always @ (posedge clk_in or posedge reset)
        // if reset then zero all 10 registers
        if (reset == 1'b1)
            {q9, q8, q7, q6, q5, q4, q3, q2, q1, q0} <= 10'b0;
        else begin
            // shift in the new that's on the D_in input
            q9 <= q8; q8 <= q7; q7 <= q6; q6 <= q5; q5 <= q4;
            q4 <= q3; q3 <= q2; q2 <= q1; q1 <= q0; q0 <= D_in;
        end
        
    // create the debounced, one-shot output pulse
    assign D_out = !q9 & q8 & q7 & q6 & q5 &
                    q4 & q3 & q2 & q1 & q0;
    
endmodule