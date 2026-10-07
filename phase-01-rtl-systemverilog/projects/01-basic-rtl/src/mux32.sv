module mux32 (
    input logic [31:0] A,
    input logic [31:0] B,
    input logic sel,
    output logic [31:0] Y
);

    assign Y = sel ? B : A;

endmodule