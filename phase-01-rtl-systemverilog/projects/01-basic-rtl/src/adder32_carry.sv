module adder32_carry (
    input  logic [31:0] A,
    input  logic [31:0] B,
    output logic [31:0] Y,
    output logic        CarryOut
);

    logic [32:0] Sum;

    assign Sum = {1'b0, A} + {1'b0, B};

    assign Y        = Sum[31:0];
    assign CarryOut = Sum[32];

endmodule