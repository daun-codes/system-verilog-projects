`timescale 1ns/1ps

module alu32_tb;

    logic [31:0] A;
    logic [31:0] B;
    logic [2:0] ALUControl;
    logic [31:0] Y;


    alu32 dut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Y(Y)
    );


    initial begin

        $dumpfile("wave/alu32.vcd");
        $dumpvars(0, alu32_tb);

        A = 32'd20;
        B = 32'd10;

        ALUControl = 3'b000;
        #10;

        $display("ADD: A=%0d B=%0d Y=%0d", A, B, Y);


        ALUControl = 3'b001;
        #10;

        $display("SUB: A=%0d B=%0d Y=%0d", A, B, Y);


        A = 32'hAAAAAAAA;
        B = 32'h55555555;
        ALUControl = 3'b010;

        #10;

        $display("AND: A=%h B=%h Y=%h", A, B, Y);


        ALUControl = 3'b011;

        #10;

        $display("OR: A=%h B=%h Y=%h", A, B, Y);


        ALUControl = 3'b100;

        #10;

        $display("XOR: A=%h B=%h Y=%h", A, B, Y);

        $finish;

    end

endmodule