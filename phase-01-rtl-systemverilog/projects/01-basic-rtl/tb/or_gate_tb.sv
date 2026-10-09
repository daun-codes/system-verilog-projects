module or_gate_tb;

    logic A;
    logic B;
    logic Y;

    or_gate dut (
        .A(A),
        .B(B),
        .Y(Y)
    );

    initial begin 
        $dumpfile("wave/or_gate.vcd");
        $dumpvars(0, or_gate_tb);

        A = 0;
        B = 0;
        #10;

        $display("A=%b B=%b Y=%b", A, B, Y);

        A = 1;
        B = 0;
        #10;


        $display("A=%b B=%b Y=%b", A, B, Y);


        A = 0;
        B = 1;
        #10;

        $display("A=%b B=%b Y=%b", A, B, Y);

        A = 1;
        B = 1;
        #10;

        $display("A=%b B=%b Y=%b", A, B, Y);

        $finish;

    end

endmodule


