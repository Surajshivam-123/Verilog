module bcd_adder (
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
);

    reg [4:0] sum_temp;
    reg [4:0] corrected_sum;

    always @(*) begin
        // Step 1: Standard binary addition of two 4-bit BCD digits + carry-in
        sum_temp = a + b + cin;

        // Step 2: Check if sum exceeds 9 (1001)
        if (sum_temp > 5'd9) begin
            corrected_sum = sum_temp + 5'd6; // Add correction factor of 6
        end else begin
            corrected_sum = sum_temp;
        end
    end

    // Carry out is 1 if the initial binary sum > 9
    assign cout = (sum_temp > 5'd9);
    
    // Lower 4 bits form the corrected BCD sum digit
    assign sum  = corrected_sum[3:0];

endmodule

`timescale 1ns / 1ps

module tb_bcd_adder;

    // Inputs
    reg [3:0] a;
    reg [3:0] b;
    reg cin;

    // Outputs
    wire [3:0] sum;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    bcd_adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        // Display header
        $display("Time(ns)\tA\tB\tCin\tCout\tSum (BCD)\tExpected Decimal");
        $display("-------------------------------------------------------------------");
        
        // Monitor changes
        $monitor("%0t\t\t%0d\t%0d\t%b\t%b\t%0d\t\t%0d", 
                 $time, a, b, cin, cout, sum, (cout * 10 + sum));

        // Test cases
        a = 4'd4; b = 4'd3; cin = 1'b0; #10; // 4 + 3 = 7 (No correction)
        a = 4'd5; b = 4'd6; cin = 1'b0; #10; // 5 + 6 = 11 (Cout=1, Sum=1)
        a = 4'd8; b = 4'd4; cin = 1'b1; #10; // 8 + 4 + 1 = 13 (Cout=1, Sum=3)
        a = 4'd9; b = 4'd9; cin = 1'b0; #10; // 9 + 9 = 18 (Cout=1, Sum=8)
        a = 4'd2; b = 4'd3; cin = 1'b1; #10; // 2 + 3 + 1 = 6 (No correction)

        $finish;
    end

endmodule