`timescale 1ns / 1ps

module add_sub_comp_tb();

    reg [3:0] x;
    reg [3:0] y;
    reg  [1:0] add_sub_comp_select;
    wire [3:0] z;
    wire carry_out;

    add_sub_comp_4bit adder_sub4 (.x(x),.y(y),.add_sub_comp_select(add_sub_comp_select),.z(z),.carry_out(carry_out));

    initial begin

    x = 4'b0101;
    y = 4'b0011;
    add_sub_comp_select = 2'b00;
    #10

    x = 4'b0111;
    y = 4'b0111;
    add_sub_comp_select = 2'b00;
    #10

    x = 4'b0100;
    y = 4'b0010;
    add_sub_comp_select = 2'b01;
    #10

    x = 4'b1011;
    y = 4'b0101;
    add_sub_comp_select = 2'b01;
    #10

    x = 4'b1110;
    y = 4'b0110;
    add_sub_comp_select = 2'b11;
    #10

    x = 4'b0101;
    y = 4'b1010;
    add_sub_comp_select = 2'b11;
    #10

    x = 4'b1100;
    y = 4'b1011;
    add_sub_comp_select = 2'b11;
    #10

    $finish;
    end


endmodule
