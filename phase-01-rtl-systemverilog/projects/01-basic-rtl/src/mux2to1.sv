module mux2_to_1 (
    input logic A,
    input logic B,
    input logic sel,
    output logic Y

);

    assign Y = sel ? A : B;

endmodule
