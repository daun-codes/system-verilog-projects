`timescale 1ns/1ps

module mux32_tb;

    logic [31:0] A;
    logic [31:0] B;
    logic SEL;
    logic [31:0] Y;

    mux32 dut (
        .A(A),
        .B(B),
        .sel(SEL),
        .Y(Y)
    );

    initial begin

        $dumpfile("wave/mux32.vcd");
        $dumpvars(0, mux32_tb);

        A = 32'h12345678;
        B = 32'hDEADBEEF;

        SEL = 0;
        #10;
        $display("A=%h B=%h SEL=%b Y=%h", A, B, SEL, Y);

        SEL = 1;
        #10;
        $display("A=%h B=%h SEL=%b Y=%h", A, B, SEL, Y);

        A = 32'hAAAAAAAA;
        B = 32'h55555555;

        SEL = 0;
        #10;
        $display("A=%h B=%h SEL=%b Y=%h", A, B, SEL, Y);

        SEL = 1;
        #10;
        $display("A=%h B=%h SEL=%b Y=%h", A, B, SEL, Y);

        $finish;

    end

endmodule