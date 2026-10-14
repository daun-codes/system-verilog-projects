
`timescale 1ns/1ps

module fsm_controller_tb;

    logic clk;
    logic start;
    logic reset;
    logic active;

    // Instantiate the FSM
    fsm_controller dut (
        .clk(clk),
        .start(start),
        .reset(reset),
        .active(active)
    );

    // Generate clock: period = 10 ns
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        start = 0;
        reset = 1;

        $dumpfile("wave/fsm_controller.vcd");
        $dumpvars(0, fsm_controller_tb);

        

        @(negedge clk);

        // Test 1: Start the simulation
        
        @(posedge clk);
        #1;
        $display("Test 1: start=%b active=%b", start, active);

        // Test 2: Assert start
        @(negedge clk);
        
        reset = 0;
        start = 1;

        @(posedge clk);
        #1;
        $display("Test 2: start=%b active=%b", start, active);

        // Test 3: Keep start asserted
        @(negedge clk);
        start = 1;
        @(posedge clk);
        #1;
        $display("Test 3: start=%b active=%b", start, active);

        // Test 4: Deassert start
        @(negedge clk);
        start = 0;
        @(posedge clk);
        #1;
        $display("Test 4: start=%b active=%b", start, active);

        $finish;
    end

endmodule
