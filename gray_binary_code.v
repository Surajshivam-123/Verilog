module gray_to_binary(
  input wire [3:0]g,
  output reg [3:0]b
);
  parameter w=4;
  genvar i;
  generate
    for(i=0;i<w;i++)begin
      assign b[i]=^(g >> i);
    end
  endgenerate
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