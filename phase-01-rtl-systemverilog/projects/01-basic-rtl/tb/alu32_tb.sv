`timescale 1ns/1ps

module alu32_tb;

    logic [31:0] A;
    logic [31:0] B;
    logic [2:0] ALUControl;
    logic [31:0] Y;

    integer passed;
    integer failed;

    alu32 dut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Y(Y)
    );

    task automatic check_result;
        input [31:0] expected;
        input string test_name;
        begin
            #10;

            if (Y === expected) begin
                $display("PASS: %0s | Y = %h", test_name, Y);
                passed = passed + 1;
            end
            else begin
                $display(
                    "FAIL: %0s | Expected = %h, Got = %h",
                    test_name, expected, Y
                );
                failed = failed + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("wave/alu32.vcd");
        $dumpvars(0, alu32_tb);

        passed = 0;
        failed = 0;
        A = 0;
        B = 0;
        ALUControl = 0;

        $display("=== ALU32 TEST START ===");

        // 1. ADD
        A = 32'd20;
        B = 32'd10;
        ALUControl = 3'b000;
        check_result(32'd30, "ADD: 20 + 10");

        // 2. ADD overflow
        A = 32'hFFFFFFFF;
        B = 32'd1;
        ALUControl = 3'b000;
        check_result(32'h00000000, "ADD: overflow");

        // 3. SUB
        A = 32'd20;
        B = 32'd10;
        ALUControl = 3'b001;
        check_result(32'd10, "SUB: 20 - 10");

        // 4. SUB produces a negative signed result
        A = 32'd5;
        B = 32'd10;
        ALUControl = 3'b001;
        check_result(32'hFFFFFFFB, "SUB: 5 - 10");

        // 5. AND
        A = 32'hAAAAAAAA;
        B = 32'h55555555;
        ALUControl = 3'b010;
        check_result(32'h00000000, "AND: alternating bits");

        // 6. OR
        A = 32'hAAAAAAAA;
        B = 32'h55555555;
        ALUControl = 3'b011;
        check_result(32'hFFFFFFFF, "OR: alternating bits");

        // 7. XOR
        A = 32'hAAAAAAAA;
        B = 32'h55555555;
        ALUControl = 3'b100;
        check_result(32'hFFFFFFFF, "XOR: alternating bits");

        // 8. Unsupported ALU control
        A = 32'd123;
        B = 32'd456;
        ALUControl = 3'b111;
        check_result(32'd1, "Invalid control returns zero");

        $display("------------------------------");
        $display("Passed: %0d", passed);
        $display("Failed: %0d", failed);
        $display("=== ALU32 TEST END ===");

        $finish;
    end

endmodule
