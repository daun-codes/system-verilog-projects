
module alu_regfile (
    input  logic        clk,
    input  logic        RegWrite,
    input  logic        WritebackSelect,

    input  logic [4:0]  ReadAddr1,
    input  logic [4:0]  ReadAddr2,
    input  logic [4:0]  WriteAddr,

    input  logic [31:0] ExternalData,
    input  logic [2:0]  ALUControl,

    output logic [31:0] ALUResult,
    output logic        Zero
);

    logic [31:0] ReadData1;
    logic [31:0] ReadData2;
    logic [31:0] WritebackData;

    // Select data to write into the register file
    always_comb begin
        if (WritebackSelect)
            WritebackData = ALUResult;
        else
            WritebackData = ExternalData;
    end

    // Register file
    regfile32 rf (
        .clk(clk),
        .RegWrite(RegWrite),
        .ReadAddr1(ReadAddr1),
        .ReadAddr2(ReadAddr2),
        .WriteAddr(WriteAddr),
        .WriteData(WritebackData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // ALU
    alu32 alu (
        .A(ReadData1),
        .B(ReadData2),
        .ALUControl(ALUControl),
        .Y(ALUResult)
    );

    assign Zero = (ALUResult == 32'b0);

endmodule
