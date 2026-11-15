module encoder8_3_tb;
    reg [0:7] tb_a;
    wire [0:2] tb_out;
  
    encoder8_3 dut (
        .a   (tb_a),
        .out (tb_out)
    );

    initial begin
        $display("Time\t Input (a)    \t Output (out)");
        $display("---------------------------------------");

        tb_a = 8'b10000000; #10;        
        tb_a = 8'b01000000; #10;       
        tb_a = 8'b00100000; #10;       
        tb_a = 8'b00010000; #10;
        tb_a = 8'b00001000; #10;
        tb_a = 8'b00000100; #10;
        tb_a = 8'b00000010; #10;
        tb_a = 8'b00000001; #10;
        $finish;
    end
    initial begin
        $monitor("%0dns\t b%b \t b%b", $time, tb_a, tb_out);
    end

endmodule


module encoder8_3(
  input wire [0:7] a,
  output wire [0:2] out
);
  assign out[2] = a[1] | a[3] | a[5] | a[7];
  assign out[1] = a[2] | a[3] | a[6] | a[7];
  assign out[0] = a[4] | a[5] | a[6] | a[7];
endmodule