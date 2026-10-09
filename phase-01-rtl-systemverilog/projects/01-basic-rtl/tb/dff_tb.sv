
`timescale 1ns/1ps

module dff_tb;

    logic clk;
    logic D;
    logic Q;

    // Instantiate the D flip-flop
    dff uut (
        .clk(clk),
        .D(D),
        .Q(Q)
    );

    // Generate clock: period = 10 ns
    always #5 clk = ~clk;

    initial begin

        $dumpfile("wave/dff.vcd");
        $dumpvars(0, dff_tb);


        clk = 0;
        D   = 0;

        

        // Test 1: Store 0
        #2;
        D = 0;
        #6;
        $display("Test 1: D=%b Q=%b", D, Q);

        // Test 2: Store 1
        #2;
        D = 1;
        #5;
        $display("Test 2: D=%b Q=%b", D, Q);

        // Test 3: Change D to 0
        #2;
        D = 0;
        #5;
        $display("Test 3: D=%b Q=%b", D, Q);

        #5;
        $finish;
    end

endmodule
