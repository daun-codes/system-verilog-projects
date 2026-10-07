`timescale 1ns/1ps

module addsub32_tb;

    logic [31:0] A;
    logic [31:0] B;
    logic        SUB;
    logic [31:0] Y;
    logic        CarryOut;

    addsub32 dut (
        .A(A),
        .B(B),
        .SUB(SUB),
        .Y(Y),
        .CarryOut(CarryOut)
    );

    initial begin

        // ADD: 10 + 20
        A = 32'd10;
        B = 32'd20;
        SUB = 0;
        #10;
        $display("ADD: A=%0d B=%0d Y=%0d Carry=%b",
                 A, B, Y, CarryOut);

        // ADD: 100 + 200
        A = 32'd100;
        B = 32'd200;
        SUB = 0;
        #10;
        $display("ADD: A=%0d B=%0d Y=%0d Carry=%b",
                 A, B, Y, CarryOut);

        // SUB: 20 - 10
        A = 32'd20;
        B = 32'd10;
        SUB = 1;
        #10;
        $display("SUB: A=%0d B=%0d Y=%0d Carry=%b",
                 A, B, Y, CarryOut);

        // SUB: 100 - 75
        A = 32'd100;
        B = 32'd75;
        SUB = 1;
        #10;
        $display("SUB: A=%0d B=%0d Y=%0d Carry=%b",
                 A, B, Y, CarryOut);

        // SUB: 10 - 20
        A = 32'd10;
        B = 32'd20;
        SUB = 1;
        #10;
        $display("SUB: A=%0d B=%0d Y=%h Carry=%b",
                 A, B, Y, CarryOut);

        $finish;

    end

endmodule