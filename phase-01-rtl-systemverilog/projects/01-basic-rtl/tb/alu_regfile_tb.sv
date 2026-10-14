
`timescale 1ns/1ps

module alu_regfile_tb;

    logic clk;
    logic RegWrite;
    logic WritebackSelect;

    logic [4:0] ReadAddr1;
    logic [4:0] ReadAddr2;
    logic [4:0] WriteAddr;

    logic [31:0] ExternalData;
    logic [2:0] ALUControl;

    logic [31:0] ALUResult;
    logic Zero;

    alu_regfile uut (
        .clk(clk),
        .RegWrite(RegWrite),
        .WritebackSelect(WritebackSelect),
        .ReadAddr1(ReadAddr1),
        .ReadAddr2(ReadAddr2),
        .WriteAddr(WriteAddr),
        .ExternalData(ExternalData),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        RegWrite = 0;
        WritebackSelect = 0;

        ReadAddr1 = 0;
        ReadAddr2 = 0;
        WriteAddr = 0;
        ExternalData = 0;
        ALUControl = 3'b000;

        $dumpfile("wave/alu_regfile.vcd");
        $dumpvars(0, alu_regfile_tb);

        // Test 1: Load R1 = 10
        @(negedge clk);
        RegWrite = 1;
        WritebackSelect = 0;
        WriteAddr = 1;
        ExternalData = 10;

        @(posedge clk);
        #1;
        $display("Test 1: Loaded R1 = 10");

        // Test 2: Load R2 = 20
        @(negedge clk);
        WriteAddr = 2;
        ExternalData = 20;

        @(posedge clk);
        #1;
        $display("Test 2: Loaded R2 = 20");

        // Test 3: Calculate R1 + R2
        @(negedge clk);
        RegWrite = 0;
        ReadAddr1 = 1;
        ReadAddr2 = 2;
        ALUControl = 3'b000;

        #1;
        $display("Test 3: R1=%0d R2=%0d ALUResult=%0d",
                 uut.ReadData1, uut.ReadData2, ALUResult);

        // Test 4: Write ALU result into R3
        @(negedge clk);
        RegWrite = 1;
        WritebackSelect = 1;
        WriteAddr = 3;

        @(posedge clk);
        #1;

        // Read back R3
        RegWrite = 0;
        ReadAddr1 = 3;
        ReadAddr2 = 0;
        #1;

        $display("Test 4: R3=%0d Zero=%b",
                 uut.ReadData1, Zero);

        $finish;
    end

endmodule
