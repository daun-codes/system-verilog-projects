
module reg32 (
    input  logic        clk,
    input  logic        en,
    input  logic [31:0] D,
    output logic [31:0] Q
);

    always_ff @(posedge clk) begin
        if (en) begin
            Q <= D;
        end
    end

endmodule
