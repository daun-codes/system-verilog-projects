module alu32_flags (
    input logic [31:0] A, 
    input logic [31:0] B,
    input logic [2:0] ALUControl,

    output logic [31:0] Y,
    output logic        Zero
);

    logic [31:0] AddResult;
    logic [31:0] SubResult;
    logic [31:0] AndResult;
    logic [31:0] OrResult;
    logic [31:0] XorResult;


    assign AddResult = A + B;
    assign SubResult = A - B;
    assign AndResult = A & B;
    assign OrResult  = A | B;
    assign XorResult = A ^ B;


    always_comb begin
        case (ALUControl)
            3'b000: Y = AddResult;
            3'b001: Y = SubResult;
            3'b010: Y = AndResult;
            3'b011: Y = OrResult;
            3'b100: Y = XorResult;

            default: Y = 32'b0;

        endcase
    end

    assign Zero = (Y == 32'b0);

endmodule