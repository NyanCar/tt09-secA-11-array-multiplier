`timescale 1ns / 1ps

module add_sub_4bit_tb();

    reg [3:0] x;
    reg [3:0] y;
    reg add_sub_select;
    wire [3:0] z;
    wire carry_out;

    add_sub_4bit adder_sub_inst (.x(x),.y(y),.add_sub_select(add_sub_select),.z(z),.carry_out(carry_out));

    initial begin

    x = 4'b1001;
    y = 4'b1010;
    add_sub_select = 1'b0;
    #10

    x = 4'b0001;
    y = 4'b0010;
    add_sub_select = 1'b0;
    #10

    x = 4'b0111;
    y = 4'b0100;
    add_sub_select = 1'b0;
    #10

    x = 4'b1010;
    y = 4'b1111;
    add_sub_select = 1'b1;
    #10

    x = 4'b1001;
    y = 4'b1001;
    add_sub_select = 1'b1;
    #10

    x = 4'b0101;
    y = 4'b1010;
    add_sub_select = 1'b0;
    #10

    x = 4'b0011;
    y = 4'b1100;
    add_sub_select = 2'b01;
    #10

    $finish;
    end


endmodule
