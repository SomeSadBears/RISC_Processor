`timescale 1ns / 1ps

/***************************************************************************
 * File Name: RISC_Processor.v
 * Project: Lab 08, RISC Processor
 * Designer: Juan Saavedra, Brianna Segura
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: Dec. 5th, 2018
 *
 * Purpose: Interconnects the control unit (cu.v) and execution unit 
 * (cpu_eu.v) to produce a working 16-bit RISC processor. 
 * The module has a clk input, to be taken from a debounced clk signal. 
 * The module has a data in (D_in) input, a data out (D_out) output  and
 * a an address output, all three of these buses will be connected to a
 * memory module. 
 * The interconnection between the control unit and the execution unit is as
 * follows: cu outputs 3'bit Write address (W_Adr), 3'bit R address (R_Adr),
 * 3'bit S address (S_Adr), 4'bit Alu operation (Alu_Op), register write 
 * enable (rw_en), s_sel, address select (addr_sel), IR load (ir_ld), 
 * PC load (pc_ld), PC increment (pc_inc), PC select (pc_sel).
 * The execution unit outputs a 16'bit IR out and three ALU status flags
 * C (carry), N (negative) and Z (zero) which are set by ALU operations.
 * 
 * Dependencies: cpu_eu.v, cu.v
 *
 * Notes: 
***************************************************************************/

module RISC_Processor(
    input           clk,
    input           reset,
    input  [15:0]   D_in,
    output          mw_en,    
    output  [7:0]   status,
    output [15:0]   D_out,
    output [15:0]   Address
    );
    
    wire            adr_sel;
    wire            s_sel;
    wire            rw_en;
    wire            ir_ld;
    wire            pc_ld;
    wire            pc_inc;
    wire            pc_sel;
    wire            C, N, Z;
    wire    [3:0]   Alu_Op;
    wire    [2:0]   W_Adr;
    wire    [2:0]   R_Adr;
    wire    [2:0]   S_Adr;
    wire   [15:0]   IR;

    
    cpu_eu  cpu_eu  (Alu_Op, W_Adr, R_Adr, S_Adr, 
                    clk, reset, adr_sel, s_sel, rw_en, 
                    ir_ld, pc_ld, pc_inc, pc_sel,
                    D_in, IR, C, N, Z, D_out, Address);
    
    cu      cu_0    (clk, reset, IR, N, Z, C, 
                    W_Adr, R_Adr, S_Adr, 
                    adr_sel, s_sel, pc_ld, pc_inc, pc_sel, ir_ld,
                    mw_en, rw_en, Alu_Op, status);
endmodule
