`timescale 1ns / 1ps

module integer_datapath(
    input clk,
    input reset,
    input W_En,
    input [2:0] W_Adr,
    input [2:0] R_Adr,
    input [2:0] S_Adr,
    input [15:0] DS,
    input S_Sel,
    input [3:0] ALU_OP,
    output [15:0] Reg_Out,
    output [15:0] Alu_Out,
    output C,
    output N,
    output Z
    );
    
    wire [15:0] R, S, S_Mux;// WR;
    
    /*
    register_file(
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
    */
    register_file reg_file_0(clk, reset, W_Adr, R_Adr, S_Adr, W_En, Alu_Out, R, S); 
    
    assign S_Mux = S_Sel ? DS : S;
    
    /*
    module alu16(
        input       [15:0]  R,
        input       [15:0]  S,
        input       [3:0]   alu_op,
        output reg  [15:0]  Y,
        output reg          N,
        output reg          Z,
        output reg          C
        );
    */
    
    alu16 alu16_0(R, S_Mux, ALU_OP, Alu_Out, N, Z, C);
    
    // assign WR       = Alu_Out   ;
    
    assign Reg_Out = R         ;
endmodule
