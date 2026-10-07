`timescale 1ns/1ps

module adder32_carry_tb;

    logic [31:0] A;
    logic [31:0] B;
    logic [31:0] Y;
    logic CarryOut;

    adder32_carry dut (
        .A(A),
        .B(B),
        .Y(Y),
        .CarryOut(CarryOut)
    );

    initial begin

        // Normal addition
        A = 32'd10;
        B = 32'd20;
        #10;
        $display("A=%0d B=%0d Y=%0d Carry=%b",
                 A, B, Y, CarryOut);

        // Another normal addition
        A = 32'd100;
        B = 32'd200;
        #10;
        $display("A=%0d B=%0d Y=%0d Carry=%b",
                 A, B, Y, CarryOut);

        // Maximum value + 1
        A = 32'hFFFFFFFF;
        B = 32'd1;
        #10;
        $display("A=%0d B=%0d Y=%h Carry=%b",
                 A, B, Y, CarryOut);

        // Large values with carry
        A = 32'hFFFFFFFF;
        B = 32'hFFFFFFFF;
        #10;
        $display("A=%0d B=%0d Y=%h Carry=%b",
                 A, B, Y, CarryOut);

        $finish;

    end

endmodule