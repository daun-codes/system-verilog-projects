module not_gate_tb;

    logic A;
    logic Y;


    not_gate dut (
        .A(A),
        .Y(Y)
    );

    initial begin
        $dumpfile("wave/not_gate.vcd");
        $dumpvars(0, not_gate_tb);

        A = 0;
        #10;

        $display("A=%b Y=%b", A, Y);

        A = 1;
        #10;

        $display("A=%b Y=%b", A, Y);

        $finish;
    end

endmodule