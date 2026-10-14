
module processor_core (
    input  logic clk,
    input  logic reset,
    input  logic start,

    input  logic [4:0]  ReadAddr1,
    input  logic [4:0]  ReadAddr2,
    input  logic [4:0]  WriteAddr,
    input  logic [31:0] ExternalData,
    input  logic [2:0]  ALUControl,
    input  logic        WritebackSelect,

    output logic [31:0] ALUResult,
    output logic        Zero,

    output logic fetch,
    output logic decode,
    output logic execute,
    output logic writeback,
    output logic RegWrite
);

    // Controller
    processor_controller controller (
        .clk(clk),
        .reset(reset),
        .start(start),
        .fetch(fetch),
        .decode(decode),
        .execute(execute),
        .writeback(writeback),
        .RegWrite(RegWrite)
    );

    // Datapath
    alu_regfile datapath (
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

endmodule
