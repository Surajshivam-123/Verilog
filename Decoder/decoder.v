// Code your design here
module decoder3_8_tb;
  reg [0:2] tb_a;
  wire [0:7] tb_out;
  
  decoder3_8 dut (
      .a   (tb_a),
      .out (tb_out)
  );
	integer i;
    initial begin
        $display("Time\t Input (a)    \t Output (out)");
        $display("---------------------------------------");
      for (i=0;i<8;i++)begin
        tb_a=i;#10;
      end
        $finish;
    end
    initial begin
        $monitor("%0dns\t b%b \t b%b", $time, tb_a, tb_out);
    end

endmodule

module decoder3_8(
  input wire [0:2] a,
  output wire [0:7] out
);
  
  assign out[0] = !a[0] & !a[1] & !a[2];
  assign out[1] = !a[0] & !a[1] & a[2];
  assign out[2] = !a[0] & a[1] & !a[2];
  assign out[3] = !a[0] & a[1] & a[2];
  assign out[4] = a[0] & !a[1] & !a[2];
  assign out[5] = a[0] & a[1] & !a[2];
  assign out[6] = a[0] & a[1] & !a[2];
  assign out[7] = a[0] & a[1] & a[2];
endmodule
