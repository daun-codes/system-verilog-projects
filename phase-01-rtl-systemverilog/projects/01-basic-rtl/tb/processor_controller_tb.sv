
`timescale 1ns/1ps

module processor_controller_tb;

    logic clk;
    logic reset;

    logic fetch;
    logic decode;
    logic execute;
    logic writeback;
    logic done;
    logic RegWrite;

    processor_controller dut (
        .clk(clk),
        .reset(reset),
        .fetch(fetch),
        .decode(decode),
        .execute(execute),
        .writeback(writeback),
        .done(done),
        .RegWrite(RegWrite)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        $dumpfile("wave/processor_controller.vcd");
        $dumpvars(0, processor_controller_tb);

        // Apply reset
        @(posedge clk);
        #1;
        $display("Reset: FETCH=%b DECODE=%b EXECUTE=%b WRITEBACK=%b",
                 fetch, decode, execute, writeback);

        // Release reset
        @(negedge clk);
        reset = 0;

        // Observe each state
        repeat (5) begin
            @(posedge clk);
            #1;
            $display("FETCH=%b DECODE=%b EXECUTE=%b WRITEBACK=%b DONE=%b RegWrite=%b",
                fetch, decode, execute, writeback, done, RegWrite);
            end

        $finish;
    end

endmodule
