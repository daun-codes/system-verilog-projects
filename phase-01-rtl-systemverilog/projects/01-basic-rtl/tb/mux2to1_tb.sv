module mux2_to_1_tb;

    logic A;
    logic B;
    logic sel;
    logic Y;


    mux2_to_1 dut (
        .A(B),
        .B(A),
        .sel(sel),
        .Y(Y)
    );

    initial begin 
        $dumpfile("wave/mux2to1.vcd");
        $dumpvars(0, mux2_to_1_tb);


        A = 0;
        B = 0;
        sel = 0;
        #10;

        $display("A=%b B=%b SEL=%b Y=%b", A, B, sel, Y);

        A = 0;
        B = 0;
        sel = 1;
        #10;

        $display("A=%b B=%b SEL=%b Y=%b", A, B, sel, Y);

        A = 1;
        B = 0;
        sel = 0;
        #10;

        $display("A=%b B=%b SEL=%b Y=%b", A, B, sel, Y);

        A = 1;
        B = 0;
        sel = 1;
        #10;

        $display("A=%b B=%b SEL=%b Y=%b", A, B, sel, Y);


        A = 0;
        B = 1;
        sel = 0;
        #10;

        $display("A=%b B=%b SEL=%b Y=%b", A, B, sel, Y);


        A = 0;
        B = 1;
        sel = 1;
        #10;

        $display("A=%b B=%b SEL=%b Y=%b", A, B, sel, Y);


        A = 1;
        B = 1;
        sel = 0;
        #10;

        $display("A=%b B=%b SEL=%b Y=%b", A, B, sel, Y);


        A = 1;
        B = 1;
        sel = 1;
        #10;

        $display("A=%b B=%b SEL=%b Y=%b", A, B, sel, Y);

        $finish;

    end

endmodule