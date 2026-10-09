
module regfile32 (
    input  logic        clk,
    input  logic        RegWrite,

    input  logic [4:0]  ReadAddr1,
    input  logic [4:0]  ReadAddr2,
    input  logic [4:0]  WriteAddr,

    input  logic [31:0] WriteData,

    output logic [31:0] ReadData1,
    output logic [31:0] ReadData2
);

    logic [31:0] registers [0:31];

    // Write operation: x0 cannot be modified
    always_ff @(posedge clk) begin
        if (RegWrite && (WriteAddr != 5'd0)) begin
            registers[WriteAddr] <= WriteData;
        end
    end

    // Read operation: x0 always returns zero
    always_comb begin
        if (ReadAddr1 == 5'd0)
            ReadData1 = 32'b0;
        else
            ReadData1 = registers[ReadAddr1];

        if (ReadAddr2 == 5'd0)
            ReadData2 = 32'b0;
        else
            ReadData2 = registers[ReadAddr2];
    end

endmodule
