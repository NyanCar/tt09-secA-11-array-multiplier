`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 07:38:17 PM
// Design Name: 
// Module Name: array_mult_structural
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


module array_mult_structural(
    input [3:0]m,
    input [3:0]q,
    output [7:0]p
    );

 
wire [2:0]carry_arr;
wire [3:0]z_out1;
wire [3:0]z_out2;
wire [3:0]z_out3;
//row 1 FA input
wire [3:0]int_sig1;
wire [3:0]int_sig1_2;

//row 1 FA output //row 2 FA input
wire [3:0]int_sig2; 
wire int_sig2_carry;
wire [3:0]int_sig2_2;

//row 2 FA output //row 3 FA input
wire [3:0]int_sig3;
wire int_sig3_carry;
wire [3:0]int_sig3_2;

and(p[0],m[0],q[0]);
and(int_sig1[0],m[1],q[0]);
and(int_sig1[1],m[2],q[0]);
and(int_sig1[2],m[3],q[0]);
and(int_sig1[3],0,0);

and(int_sig1_2[0],m[0],q[1]);
and(int_sig1_2[1],m[1],q[1]);
and(int_sig1_2[2],m[2],q[1]);
and(int_sig1_2[3],m[3],q[1]);

and(int_sig2_2[0],m[0],q[2]);
and(int_sig2_2[1],m[1],q[2]);
and(int_sig2_2[2],m[2],q[2]);
and(int_sig2_2[3],m[3],q[2]);

and(int_sig3_2[0],m[0],q[3]);
and(int_sig3_2[1],m[1],q[3]);
and(int_sig3_2[2],m[2],q[3]);
and(int_sig3_2[3],m[3],q[3]);


add_sub_4bit inst0 (.x(int_sig1), .y(int_sig1_2), .add_sub_select(1'b0), .z(z_out1), .carry_out(carry_arr[0]));
assign p[1] = z_out1[0];

assign int_sig2[0] = z_out1[1];
assign int_sig2[1] = z_out1[2];
assign int_sig2[2] = z_out1[3];
assign int_sig2[3] = carry_arr[0];

add_sub_4bit inst1 (.x(int_sig2), .y(int_sig2_2), .add_sub_select(1'b0), .z(z_out2), .carry_out(carry_arr[1]));
assign p[2] = z_out2[0];

assign int_sig3[0] = z_out2[1];
assign int_sig3[1] = z_out2[2];
assign int_sig3[2] = z_out2[3];
assign int_sig3[3] = carry_arr[1];

add_sub_4bit inst2 (.x(int_sig3), .y(int_sig3_2), .add_sub_select(1'b0), .z(z_out3), .carry_out(carry_arr[2]));

assign p[3] = z_out3[0];
assign p[4] = z_out3[1];
assign p[5] = z_out3[2];
assign p[6] = z_out3[3];
assign p[7] = carry_arr[2];

endmodule