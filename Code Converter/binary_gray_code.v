module binary_to_graycode(
  input wire [3:0]b,
  output reg [3:0]g
);
  always@(*)begin
    g[0]=b[0] ^ b[1];
    g[1]=b[1] ^ b[2];
    g[2]=b[2] ^ b[3];
    g[3]=b[3];
  end
endmodule

module test_bench_binary_to_graycode;
  reg [3:0]tb;
  wire [3:0]tg;
  int i;
  binary_to_graycode dut(tb,tg);
  initial begin
    for(i=0;i<16;i++)begin
      tb=i;#10;
    end
  end
  initial begin
    $display("Binary Code \t Gray Code");
    $monitor("%b \t \t \t %b",tb,tg);
  end
endmodule