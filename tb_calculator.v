`timescale 1ns/1ps
module tb_calculator;
    parameter WIDTH = 8;
    reg clk, rst, start;
    reg [1:0] op;
    reg [WIDTH-1:0] a, b;
    wire [2*WIDTH-1:0] result;
    wire valid;
    wire [WIDTH-1:0] quotient, remainder;
    wire done_div;

    calculator #(.WIDTH(WIDTH)) uut (
        .clk(clk), .rst(rst), .start(start), .op(op), .a(a), .b(b),
        .result(result), .valid(valid), .quotient(quotient), .remainder(remainder), .done_div(done_div)
    );

    initial begin
        clk = 0; forever #5 clk = ~clk; // 100MHz style -> 10ns period
    end

    initial begin
        rst = 1; start = 0; a = 0; b = 0; op = 0;
        #20;
        rst = 0;
        // Test ADD: 45 + 22 = 67
        a = 8'd45; b = 8'd22; op = 2'b00; start = 1; #10; start = 0;
        #20;
        $display("ADD: %0d + %0d = %0d (result lower WIDTH) valid=%b", a, b, result[7:0], valid);

        // Test SUB: 100 - 55 = 45
        #20;
        a = 8'd100; b = 8'd55; op = 2'b01; start = 1; #10; start = 0;
        #20;
        $display("SUB: %0d - %0d = %0d valid=%b", a, b, result[7:0], valid);

        // Test MUL: 12 * 11 = 132
        #20;
        a = 8'd12; b = 8'd11; op = 2'b10; start = 1; #10; start = 0;
        #20;
        $display("MUL: %0d * %0d = %0d valid=%b", a, b, result, valid);

        // Test DIV: 200 / 13 = 15 rem 5
        #20;
        a = 8'd200; b = 8'd13; op = 2'b11; start = 1; #10; start = 0;
        // wait for done
        wait(done_div == 1);
        #10;
        $display("DIV: %0d / %0d -> Q=%0d R=%0d valid=%b", a, b, quotient, remainder, valid);

        #50;
        $finish;
    end
endmodule
