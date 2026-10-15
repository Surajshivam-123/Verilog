// =================================================================
// 1. Leaf Child Module: 1-bit Full Adder
// =================================================================
module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    // Continuous assignment using dataflow modeling
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

// =================================================================
// 2. Parent Top Module: 4-Bit Ripple Carry Adder
// =================================================================
module ripple_carry_adder_4bit (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire       Cin,
    output wire [3:0] Sum,
    output wire       Cout
);
    // Internal carry chain nets (connecting sub-modules)
    wire [2:0] c;

    // Instantiating 4 full adders using "Connection by Name"
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

// =================================================================
// 3. Testbench Demonstrating Port Connection Rules & Arrays
// =================================================================
module tb_ripple_carry_adder;
    // Port Connection Rule in Testbench:
    // Inputs to DUT must be driven -> declared as 'reg'
    // Outputs from DUT are monitored -> declared as 'wire'
    reg  [3:0] tb_A;
    reg  [3:0] tb_B;
    reg        tb_Cin;
    wire [3:0] tb_Sum;
    wire       tb_Cout;

    // Array / Memory declaration: 4 test vectors of 9 bits each
    // Format: {Cin, A[3:0], B[3:0]}
    reg [8:0] test_vectors [0:3];
    integer i;

    // Instantiate Device Under Test (DUT)
    ripple_carry_adder_4bit dut (
        .A    (tb_A),
        .B    (tb_B),
        .Cin  (tb_Cin),
        .Sum  (tb_Sum),
        .Cout (tb_Cout)
    );

    initial begin
        // Initialize test vectors into array
        test_vectors[0] = 9'b0_0010_0011; // 2 + 3 + Cin(0) = 5
        test_vectors[1] = 9'b0_0101_0101; // 5 + 5 + Cin(0) = 10
        test_vectors[2] = 9'b1_1111_0000; // 15 + 0 + Cin(1) = 16 (Sum=0, Cout=1)
        test_vectors[3] = 9'b1_1111_1111; // 15 + 15 + Cin(1) = 31 (Sum=15, Cout=1)

        // Iterate through array elements
        for (i = 0; i < 4; i = i + 1) begin
            {tb_Cin, tb_A, tb_B} = test_vectors[i];
            #10; // Wait 10 time units for evaluationation
            $display("Vector %0d: A=%d, B=%d, Cin=%b | Sum=%d, Cout=%b", 
                     i, tb_A, tb_B, tb_Cin, tb_Sum, tb_Cout);
        end
        $finish;
    end
endmodule