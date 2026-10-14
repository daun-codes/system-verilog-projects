
module task_test;

    task automatic run_transaction;
        begin
            $display("Task works!");
        end
    endtask

    initial begin
        run_transaction;
        $finish;
    end

endmodule
