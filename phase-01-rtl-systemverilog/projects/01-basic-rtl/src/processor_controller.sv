
module processor_controller (
    input  logic clk,
    input  logic reset,
    input  logic start,

    output logic fetch,
    output logic decode,
    output logic execute,
    output logic writeback,
    output logic RegWrite
);

    typedef enum logic [1:0] {
        FETCH,
        DECODE,
        EXECUTE,
        WRITE_BACK
    } state_t;

    state_t current_state, next_state;

    // State register
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= FETCH;
        else
            current_state <= next_state;
    end

    // Next-state logic
    always_comb begin
        case (current_state)
            FETCH: begin
                if (start)
                    next_state = DECODE;
                else
                    next_state = FETCH;
            end

            DECODE:     next_state = EXECUTE;
            EXECUTE:    next_state = WRITE_BACK;
            WRITE_BACK: next_state = FETCH;

            default:    next_state = FETCH;
        endcase
    end

    // Control outputs
    always_comb begin
        fetch     = (current_state == FETCH);
        decode    = (current_state == DECODE);
        execute   = (current_state == EXECUTE);
        writeback = (current_state == WRITE_BACK);
        RegWrite  = (current_state == WRITE_BACK);
    end

endmodule
