`timescale 1ns/1ps


module reg32_tb;


    logic           clk;
    logic           en;
    logic [31:0]    D;
    logic [31:0]    Q;


    reg32 dut (
        .clk(clk),
        .en(en),
        .D(D),
        .Q(Q)
    );


    always #5 clk = ~clk;


    initial begin

        clk = 0;
        en  = 0;
        D   = 32'b0;

        $dumpfile("wave/reg32.vcd");
        $dumpvars(0, reg32_tb);

        // Test 1: Enable and store 100
        @(negedge clk);
        en = 1;
        D = 32'd100;

        @(posedge clk);
        #1;
        $display("Test 1: en=%b D=%0d Q=%0d", en, D, Q);

        // Test 2: Disable and attempt to store 200
        @(negedge clk);
        en = 0;
        D = 32'd200;

        @(posedge clk);
        #1;
        $display("Test 2: en=%b D=%0d Q=%0d", en, D, Q);

        // Test 3: Enable and store 300
        @(negedge clk);
        en = 1;
        D = 32'd300;

        @(posedge clk);
        #1;
        $display("Test 3: en=%b D=%0d Q=%0d", en, D, Q);

        #5;
        $finish;
    end

endmodule


