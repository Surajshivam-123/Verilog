module comparator_2bit_gate (
    input [1:0] a,
    input [1:0] b,
    output a_greater,
    output a_less,
    output a_equal
);

    wire msb_eq;

    // Equality check for MSBs (using XNOR)
    assign msb_eq = ~(a[1] ^ b[1]);

    // Comparator outputs using boolean expressions
    assign a_equal   = msb_eq & (~(a[0] ^ b[0]));
    
    assign a_greater = (a[1] & ~b[1]) | (msb_eq & (a[0] & ~b[0]));
    
    assign a_less    = (~a[1] & b[1]) | (msb_eq & (~a[0] & b[0]));

endmodule

`timescale 1ns / 1ps

module tb_comparator_2bit_gate;

    // Inputs
    reg [1:0] a;
    reg [1:0] b;

    // Outputs
    wire a_greater;
    wire a_less;
    wire a_equal;

    // Instantiate the Unit Under Test (UUT)
    comparator_2bit_gate uut (
        .a(a),
        .b(b),
        .a_greater(a_greater),
        .a_less(a_less),
        .a_equal(a_equal)
    );

    integer i, j;

    initial begin
        // Display header
        $display("Time(ns)\tA\tB\tGreater\tLess\tEqual");
        $display("----------------------------------------------");
        
        // Monitor changes
        $monitor("%0t\t\t%b\t%b\t%b\t%b\t%b", 
                 $time, a, b, a_greater, a_less, a_equal);

        // Iterate through all 16 combinations (4 values of A x 4 values of B)
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                a = i[1:0];
                b = j[1:0];
                #10;
            end
        end

        $finish;
    end

endmodule