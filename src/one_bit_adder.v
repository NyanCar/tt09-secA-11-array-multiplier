`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 05:16:21 PM
// Design Name: 
// Module Name: one_bit_adder
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


module one_bit_adder(
    input x,
    input y,
    input cin,
    output z,
    output cout
    );
    wire w1, w2, w3;
    assign z = x^y^cin;
    
    assign w1 = x&y;
    assign w2 = x&cin;
    assign w3 = y&cin;
    
    assign cout = w1|w2|w3;
    
endmodule
