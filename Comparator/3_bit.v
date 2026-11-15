module comparator_3bit_gate (
    input [2:0] a,
    input [2:0] b,
    output a_greater,
    output a_less,
    output a_equal
);

    wire eq2, eq1, eq0;

    // Bitwise equality checks (XNOR)
    assign eq2 = ~(a[2] ^ b[2]);
    assign eq1 = ~(a[1] ^ b[1]);
    assign eq0 = ~(a[0] ^ b[0]);

    // Overall equality
    assign a_equal   = eq2 & eq1 & eq0;
    
    // Greater than logic
    assign a_greater = (a[2] & ~b[2]) | 
                       (eq2 & (a[1] & ~b[1])) | 
                       (eq2 & eq1 & (a[0] & ~b[0]));
    
    // Less than logic
    assign a_less    = (~a[2] & b[2]) | 
                       (eq2 & (~a[1] & b[1])) | 
                       (eq2 & eq1 & (~a[0] & b[0]));

endmodule

`timescale 1ns / 1ps

module tb_comparator_3bit_gate;

    // Inputs
    reg [2:0] a;
    reg [2:0] b;

    // Outputs
    wire a_greater;
    wire a_less;
    wire a_equal;

    // Instantiate the Unit Under Test (UUT)
    comparator_3bit_gate uut (
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

        // Iterate through all 64 combinations (8 values of A x 8 values of B)
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                a = i[2:0];
                b = j[2:0];
                #10;
            end
        end

        $finish;
    end

endmodule