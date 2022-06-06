`timescale 1ns / 1ps

module debounce(
    input   clk,
    input   reset,
    input   D_in,
    output  D_out
    );
    
    wire clk_500Hz;
    // module clk_div (clk_in, reset, clk_out);
    clk_div clk_div_500Hz (clk, reset, clk_500Hz);
    
    /*
    module debouncer(
        input D_in,
        input clk_in,
        input reset,
        output D_out
        );
    */
    debouncer debouncer_0(D_in, clk_500Hz, reset, D_out);
endmodule
