module comparator_1bit (
    input a,
    input b,
    output a_greater,
    output a_less,
    output a_equal
);

    assign a_greater = a & ~b;
    assign a_less    = ~a & b;
    assign a_equal   = ~(a ^ b); // XNOR gate

endmodule

`timescale 1ns / 1ps

module tb_comparator_1bit;

    // Inputs
    reg a;
    reg b;

    // Outputs
    wire a_greater;
    wire a_less;
    wire a_equal;

    // Instantiate the Unit Under Test (UUT)
    comparator_1bit uut (
        .a(a),
        .b(b),
        .a_greater(a_greater),
        .a_less(a_less),
        .a_equal(a_equal)
    );

    initial begin
        // Display header
        $display("Time(ns)\tA\tB\tGreater\tLess\tEqual");
        $display("----------------------------------------------");
        
        // Monitor changes
        $monitor("%0t\t\t%b\t%b\t%b\t%b\t%b", 
                 $time, a, b, a_greater, a_less, a_equal);

        // Test cases: all 4 combinations of 1-bit inputs
        a = 1'b0; b = 1'b0; #10;
        a = 1'b0; b = 1'b1; #10;
        a = 1'b1; b = 1'b0; #10;
        a = 1'b1; b = 1'b1; #10;

        $finish;
    end

endmodule