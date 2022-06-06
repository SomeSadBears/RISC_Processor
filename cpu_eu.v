`timescale 1ns / 1ps

// worked on 11/6/2018 from 12:30pm to 1:15pm
// worked on 11/7/2018 from 11:00am to 12:00pm

/***************************************************************************
 * File Name: cpu_eu.v
 * Project: Lab 07, CPU Execution Unit
 * Designer: Juan Saavedra, Brianna Segura
 * Email: juan.saavedra01@student.csulb.edu
 * Rev. Date: Nov. 6th, 2018
 *
 * Purpose: This module models a CPU execution unit. 
 * Two instances of reg_pc are generated and named IR and PC.
 * The IR (instruction register) will be used to store the instructions
 * to be executed by the rest of the cpu_eu. The IR takes the ir_ld input
 * from the cpu_eu as its ld (load enable) input, a hardcoded 1'b0 is
 * used as the IR pc_inc input, the IR d_in input comes from the cpu_eu D_in
 * input, and a 16-bit IR_out wire is used as the d_out output.
 * The values of the IR_out wire are assigned to several smaller wires
 * as follows: 
 *      Alu_Op = IR_out[15:12];
 *      W_Adr  = IR_out  [8:6];
 *      R_Adr  = IR_out  [5:3];
 *      S_Adr  = IR_out  [2:0];
 * The PC (program counter) register uses the cpu_eu ports pc_ld, pc_inc,
 * D_out and PC_out as its ld, pc_inc, d_in and d_out ports, respectively.
 * An instance of the integer_datapath is created and takes the cpu_eu.v
 * reg_w_en and s_sel inputs as its W_En and S_Sel inputs, respectively.
 * The integer_datapath ALU_OP, W_Adr, R_Adr and S_Adr inputs are all taken
 * from their namesake wires as defined above, meaning all integer_datapath
 * operations are a function of the IR_out output. The integer_datapath 
 * DS input is taken from the cpu_eu D_in input. The Reg_Out output is 
 * connected to wire Reg_out_to_mux, while Alu_Out is connected to D_out 
 * output and C, N, and Z are connected to their corresponding cpu_eu outputs.
 * A multiplexor takes adr_sel and uses it to select whether the cpu_eu Address 
 * output will be assigned to Reg_out_to_mux (Reg_Out from the datapath) if 
 * adr_sel is asserted or PC_out (from PC register) if adr_sel is unasserted.
 * 
 * Dependencies: reg_pc.v, integer_datapath.v
 *
 * Notes: 
***************************************************************************/

module cpu_eu(
    input   [3:0]   Alu_Op,
    input   [2:0]   W_Adr,
    input   [2:0]   R_Adr,
    input   [2:0]   S_Adr,
    input   clk,
    input   reset,
    input   adr_sel,
    input   s_sel,
    input   reg_w_en,
    input   ir_ld,
    input   pc_ld,
    input   pc_inc,
    input   pc_sel,
    input  [15:0] D_in,
    output [15:0] IR_OUT,
    output  C,
    output  N,
    output  Z,
    output [15:0] D_out,
    output [15:0] Address
    );
    
    wire   [15:0]   IR_out;
    wire   [15:0]   PC_out;
    wire   [15:0]   Reg_out_to_mux;
    wire   [15:0]   se_IR_add;
    wire   [15:0]   PC_in;

    // module reg_pc(clk, reset, ld, pc_inc, [15:0] d_in, [15:0] d_out);
    reg_pc IR(clk, reset, ir_ld, (1'b0), D_in, IR_out);
    
    assign se_IR_add = (PC_out + {{8{IR_out[7]}},IR_out[7:0]});
    
    // assign Alu_Op = {IR_out[15], IR_out[14], IR_out[13], IR_out[12]};//IR_out[15:12];
    // assign W_Adr  = {IR_out[8], IR_out[7], IR_out[6]};//IR_out  [8:6];
    // assign R_Adr  = {IR_out[5], IR_out[4], IR_out[3]};//IR_out  [5:3];
    // assign S_Adr  = {IR_out[2], IR_out[1], IR_out[0]};//IR_out  [2:0];
    
    // module integer_datapath(clk, reset, W_En, [2:0] W_Adr, [2:0] R_Adr, 
    //   [2:0] S_Adr, [15:0] DS, S_Sel, [3:0] ALU_OP, [15:0] Reg_Out, [15:0] Alu_Out, C, N, Z);
    
    integer_datapath int_datapath_0 (clk, reset, reg_w_en, W_Adr, R_Adr, S_Adr, D_in, s_sel, Alu_Op, Reg_out_to_mux, D_out, C, N, Z);
    
    assign PC_in = pc_sel ? D_out : se_IR_add;
    
    // module reg_pc(clk, reset, ld, pc_inc, [15:0] d_in, [15:0] d_out);
    reg_pc PC (clk, reset, pc_ld, pc_inc, PC_in, PC_out);
    
    assign Address = adr_sel ? Reg_out_to_mux : PC_out;
    assign IR_OUT = IR_out;
    
endmodule