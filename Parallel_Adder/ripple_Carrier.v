module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
module ripple_carry_adder_4bit (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire       Cin,
    output wire [3:0] Sum,
    output wire       Cout
);
    wire [2:0] c;

    full_adder fa0 (
        .a    (A[0]),
        .b    (B[0]),
        .cin  (Cin),
        .sum  (Sum[0]),
        .cout (c[0])
    );

    full_adder fa1 (
        .a    (A[1]),
        .b    (B[1]),
        .cin  (c[0]),
        .sum  (Sum[1]),
        .cout (c[1])
    );

    full_adder fa2 (
        .a    (A[2]),
        .b    (B[2]),
        .cin  (c[1]),
        .sum  (Sum[2]),
        .cout (c[2])
    );

    full_adder fa3 (
        .a    (A[3]),
        .b    (B[3]),
        .cin  (c[2]),
        .sum  (Sum[3]),
        .cout (Cout)
    );
endmodule

module tb_ripple_carry_adder;
    reg  [3:0] tb_A;
    reg  [3:0] tb_B;
    reg        tb_Cin;
    wire [3:0] tb_Sum;
    wire       tb_Cout;

    reg [8:0] test_vectors [0:3];
    integer i;

    ripple_carry_adder_4bit dut (
        .A    (tb_A),
        .B    (tb_B),
        .Cin  (tb_Cin),
        .Sum  (tb_Sum),
        .Cout (tb_Cout)
    );

    initial begin
        test_vectors[0] = 9'b0_0010_0011; 
        test_vectors[1] = 9'b0_0101_0101; 
        test_vectors[2] = 9'b1_1111_0000; 
        test_vectors[3] = 9'b1_1111_1111;

       
        for (i = 0; i < 4; i = i + 1) begin
            {tb_Cin, tb_A, tb_B} = test_vectors[i];
            #10;
            $display("Vector %0d: A=%d, B=%d, Cin=%b | Sum=%d, Cout=%b", 
                     i, tb_A, tb_B, tb_Cin, tb_Sum, tb_Cout);
        end
        $finish;
    end
endmodule