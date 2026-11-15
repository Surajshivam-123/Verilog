module gray_to_binary(
    input [3:0] gray_in,
    output [3:0] bin_out
);

    assign bin_out[3] = gray_in[3];
    assign bin_out[2] = bin_out[3] ^ gray_in[2];
    assign bin_out[1] = bin_out[2] ^ gray_in[1];
    assign bin_out[0] = bin_out[1] ^ gray_in[0];

endmodule


module test_bench_gray_to_binary;
  wire [3:0]tb;
  reg [3:0]tg;
  int i;
  gray_to_binary dut(tg,tb);
  initial begin
    for(i=0;i<16;i++)begin
      tg=i;#10;
    end
  end
  initial begin
    $display("Gray Code \t Binary Code");
    $monitor("%b \t \t \t %b",tg,tb);
  end
endmodule