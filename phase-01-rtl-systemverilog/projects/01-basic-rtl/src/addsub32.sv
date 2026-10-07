module addsub32 (
    input  logic [31:0] A,
    input  logic [31:0] B,
    input  logic        SUB,
    output logic [31:0] Y,
    output logic        CarryOut
);

    logic [31:0] B_modified;
    logic [32:0] Sum;

    assign B_modified = B ^ {32{SUB}};

    assign Sum = {1'b0, A} +
                 {1'b0, B_modified} +
                 SUB;

    assign Y        = Sum[31:0];
    assign CarryOut = Sum[32];

endmodule