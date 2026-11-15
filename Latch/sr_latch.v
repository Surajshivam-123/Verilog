module sr_latch (
    input s,
    input r,
    output q,
    output q_bar
);

    // Gate-level implementation using NOR gates with feedback
    assign q=~(r | q_bar);
    assign q_bar=~(s | q);

endmodule

`timescale 1ns / 1ps

module tb_sr_latch;

    // Inputs
    reg s;
    reg r;

    // Outputs
    wire q;
    wire q_bar;

    // Instantiate the Unit Under Test (UUT)
    sr_latch uut (
        .s(s),
        .r(r),
        .q(q),
        .q_bar(q_bar)
    );

    initial begin
        // Display header
        $display("Time(ns)\tS\tR\tQ\tQ_bar\tState");
        $display("--------------------------------------------");
        
        // Monitor changes
        $monitor("%0t\t\t%b\t%b\t%b\t%b", $time, s, r, q, q_bar);

        // Apply test vectors
        s = 1'b0; r = 1'b0; #10; // Hold state (assuming initial arbitrary or 0)
        s = 1'b1; r = 1'b0; #10; // Set: Q=1, Q_bar=0
        s = 1'b0; r = 1'b0; #10; // Hold state (retains Q=1)
        s = 1'b0; r = 1'b1; #10; // Reset: Q=0, Q_bar=1
        s = 1'b0; r = 1'b0; #10; // Hold state (retains Q=0)
        s = 1'b1; r = 1'b1; #10; // Invalid / Forbidden state (both Q and Q_bar go to 0)
        s = 1'b0; r = 1'b0; #10; // Recovery / unstable state

        $finish;
    end

endmodule