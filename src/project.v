/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_secA_11_nyancar_alanz23 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
 
	wire [3:0]m = ui_in[7:4];
	wire [3:0]q = ui_in[3:0];
	wire [7:0]p;

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

assign uo_out = p;



  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule

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

