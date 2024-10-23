`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 05:00:15 PM
// Design Name: 
// Module Name: add_sub_bit4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module add_sub_4bit(
    input [3:0] x,
    input [3:0] y,
    input add_sub_select,
    output [3:0] z,
    output carry_out
    );
    
    wire [3:0]carry_arr;
    
    
    one_bit_adder inst0 (.x(x[0]), .y(y[0]^add_sub_select), .cin(add_sub_select), .z(z[0]), .cout(carry_arr[0]));
    
    genvar i;
    
    generate
        for (i=1; i<4; i = i+1) begin: one_bit_generate
            one_bit_adder gen_inst(.x(x[i]), .y(y[i]^add_sub_select), .cin(carry_arr[i-1]), .z(z[i]), .cout(carry_arr[i]));
        end
    endgenerate 
    assign carry_out = carry_arr[3];
    
endmodule
