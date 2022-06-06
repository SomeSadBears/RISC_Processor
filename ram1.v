`timescale 1ns / 1ps

module ram1(
    input clk,
    input w_en,
    input [7:0] addr,
    input [15:0] d_in,
    output [15:0] d_out
    );
    
    ram_256x16 your_instance_name (
      .clka(clk),    // input wire clka
      .wea(w_en),      // input wire [0 : 0] wea
      .addra(addr),  // input wire [7 : 0] addra
      .dina(d_in),    // input wire [15 : 0] dina
      .douta(d_out)  // output wire [15 : 0] douta
    );
endmodule
