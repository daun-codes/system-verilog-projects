
module fsm_controller (
    input  logic clk,
    input  logic start,
    input  logic reset,
    output logic active
);

    // Define our states
    typedef enum logic {
        IDLE,
        ACTIVE
    } state_t;

    state_t current_state, next_state;

    // State memory: update on the rising clock edge
    always_ff @(posedge clk) begin
        if (reset)
            current_state <=IDLE;
        else
            current_state <= next_state;
    end

    // Decide the next state
    always_comb begin
        case (current_state)
            IDLE: begin
                if (start)
                    next_state = ACTIVE;
                else
                    next_state = IDLE;
            end

            ACTIVE: begin
                if (start)
                    next_state = ACTIVE;
                else
                    next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Output depends on the current state
    always_comb begin
        active = (current_state == ACTIVE);
    end

endmodule
