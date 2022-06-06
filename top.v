`timescale 1ns / 1ps

/***************************************************************************
 * File Name: top.v
 * Project: Lab 08, RISC Processor
 * Designer: Juan Saavedra, Brianna Segura
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: Dec. 5th, 2018
 *
 * Purpose: Interconnects the RISC processor module with a 256x16 memory 
 * (module ram1.v), display controller, two instances of a debounce module
 * and a memory dump counter register.
 * The debounce modules take their input signals from external buttons 
 * assigned to inputs stem_mem and step_clk. The debounce modules output
 * debounced signals which are to be used as clk inputs by other modules.
 * The RISC processesor takes its clk input from the debounced_clk signal,
 * the 16'bit bus data input (D_in) comes from the data output from the 
 * memory module. Similarly, the RISC processor D_out is connected to the 
 * memory module's data input. The RISC processor also outputs a 1'bits mw_en
 * connects to the write enable input of the memory module. The LED output
 * connects directly to the board's LEDs and is used to show the current 
 * state the control unit finite state machine is on. The RISC processor 
 * address output is multiplexed with the output of a mem_dump_counter 
 * register (a simple counter register, started at 0). The lower 
 * eight bits of the output of the multiplexed address and counter 
 * register are used as the address input for the memory module.
 * The display controller data input (named seg) takes its upper 16'bits
 * from the output of the address multiplexor and its lower 16'bits from 
 * the memory data output (which is also the RISC processor's data input).
 * Lastly, the display contorller's seg_out output is connnected to the 
 * 7-segment display's cathode, meanwhile the AN output is connected to
 * the anodes.
 * 
 * Dependencies: debounce.v, RISC_processor.v, reg_pc.v, ram1.v, 
 * display_controller.v
 *
 * Notes: 
***************************************************************************/

module top(
    input           clk,
    input           reset,
    input           step_mem,
    input           step_clk,
    input           dump_mem,
    output  [7:0]   LED,
    output  [7:0]   AN,
    output  [6:0]   seg_out
    );
    
    wire            debounced_mem;
    wire            debounced_clk;
    wire            mw_en;
    wire    [15:0]  Address;
    wire    [15:0]  RISC_D_out;
    wire    [15:0]  RISC_D_in;
    wire    [15:0]  mem_counter_out;
    wire    [15:0]  mux_mem_out;
    
    /*
    module debounce(
        input   clk,
        input   reset,
        input   D_in,
        output  D_out);
    */
    
    debounce debounce_mem(clk, reset, step_mem, debounced_mem);
    debounce debounce_clk(clk, reset, step_clk, debounced_clk);
    
    /*
    module RISC_Processor(
        input           clk,
        input           reset,
        input  [15:0]   D_in,
        output          mw_en,    
        output  [7:0]   status,
        output [15:0]   D_out,
        output [15:0]   Address
        );
    */
    
    RISC_Processor RISC(debounced_clk, reset, RISC_D_in, mw_en, LED, RISC_D_out, Address);
   
    /*
    module reg_pc(
        input clk,
        input reset,
        input ld,
        input pc_inc,
        input [15:0] d_in,
        output reg [15:0] d_out);
    */
    
    reg_pc mem_counter(debounced_mem, reset, 1'b0, 1'b1, 15'b0, mem_counter_out);
    
    
    assign mux_mem_out = dump_mem ? mem_counter_out : Address;
    
    /*
    module display_controller(
        input           clk,
        input           reset,
        input   [31:0]  seg,
        output  [7:0]   AN,
        output  [6:0]   seg_out
        );
    */
    
    /*
    module ram1(
        input clk,
        input w_en,
        input [7:0] addr,
        input [15:0] d_in,
        output [15:0] d_out
        );
    */
    ram1 ram(clk, mw_en, mux_mem_out[7:0], RISC_D_out, RISC_D_in);
    
    display_controller disp_ctrl(clk, reset, {mux_mem_out, RISC_D_in}, AN, seg_out);

endmodule
