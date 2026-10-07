`timescale 1ps/1ps

module adder32_tb;

    logic [31:0] A;
    logic [31:0] B;
    logic [31:0] Y;

    adder32 dut (
        .A(A),
        .B(B),
        .Y(Y)

    );

    initial begin 

        $dumpfile("wave/adder32.vcd");
        $dumpvars(0, adder32_tb);

        A = 32'd10;
        B = 32'h0F;

        #10;

        $display("A=%0d B=%0d Y=%0d", A, B, Y);


        A = 32'd30;
        B = 32'hA1;

        #10;

        $display("A=%0d B=%0d Y=%0d", A, B, Y);


        A = 32'd5;
        B = 32'h2;

        #10;

        $display("A=%0d B=%0d Y=%0d", A, B, Y);


        A = 32'd128;
        B = 32'h11F;

        #10;

        $display("A=%0d B=%0d Y=%0d", A, B, Y);

        $finish;

    end

endmodule


