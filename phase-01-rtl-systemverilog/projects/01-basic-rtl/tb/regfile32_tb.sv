
`timescale 1ns/1ps

module regfile32_tb;

    logic clk;
    logic RegWrite;

    logic [4:0] ReadAddr1;
    logic [4:0] ReadAddr2;
    logic [4:0] WriteAddr;

    logic [31:0] WriteData;
    logic [31:0] ReadData1;
    logic [31:0] ReadData2;

    // Instantiate the register file
    regfile32 uut (
        .clk(clk),
        .RegWrite(RegWrite),
        .ReadAddr1(ReadAddr1),
        .ReadAddr2(ReadAddr2),
        .WriteAddr(WriteAddr),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        RegWrite = 0;

        ReadAddr1 = 0;
        ReadAddr2 = 0;
        WriteAddr = 0;
        WriteData = 0;

        $dumpfile("wave/regfile32.vcd");
        $dumpvars(0, regfile32_tb);

        // Test 1: Write 100 into register 5
        @(negedge clk);
        RegWrite = 1;
        WriteAddr = 5;
        WriteData = 100;

        @(posedge clk);
        #1;
        ReadAddr1 = 5;
        #1;
        $display("Test 1: R5=%0d", ReadData1);

        // Test 2: Write 200 into register 10
        @(negedge clk);
        WriteAddr = 10;
        WriteData = 200;

        @(posedge clk);
        #1;
        ReadAddr1 = 5;
        ReadAddr2 = 10;
        #1;
        $display("Test 2: R5=%0d R10=%0d",
                 ReadData1, ReadData2);

        // Test 3: Disable writes and try to overwrite R5
        @(negedge clk);
        RegWrite = 0;
        WriteAddr = 5;
        WriteData = 999;

        @(posedge clk);
        #1;
        ReadAddr1 = 5;
        ReadAddr2 = 10;
        #1;
        $display("Test 3: R5=%0d R10=%0d",
                 ReadData1, ReadData2);

        // Test 4: Write 1234 into register 31
        @(negedge clk);
        RegWrite = 1;
        WriteAddr = 31;
        WriteData = 1234;

        @(posedge clk);
        #1;
        ReadAddr1 = 31;
        ReadAddr2 = 10;
        #1;
        $display("Test 4: R31=%0d R10=%0d",
                 ReadData1, ReadData2);


         // Test 5: Attempt to write 999 into x0
        @(negedge clk);
        RegWrite = 1;
        WriteAddr = 0;
        WriteData = 999;

        @(posedge clk);
        #1;
        ReadAddr1 = 0;
        #1;
        $display("Test 5: x0=%0d (expected 0)", ReadData1);

        // Test 6: Read x0 and a normal register
        ReadAddr1 = 0;
        ReadAddr2 = 5;
        #1;
        $display("Test 6: x0=%0d R5=%0d",
                 ReadData1, ReadData2);

        $finish;
    end

endmodule
