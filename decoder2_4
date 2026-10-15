module decoder2_4(
  input wire [0:1]in,
  input wire enable,
  output reg [0:3]out
);
  always @ (*) begin
    if(!enable) begin
      out=4'b0;
    end
    else begin
      case(in)
        2'b00:out=4'b0001;
        2'b01:out=4'b0010;
        2'b10:out=4'b0100;
      	2'b11:out=4'b1000;
      endcase
    end
  end
endmodule

module test_bench_decoder2_4;
  reg [0:1] tb_in;
  reg enable;
  wire [0:3] tb_out;
  int i;
  decoder2_4 dut(tb_in,enable,tb_out);
  initial begin
    enable=1;
    for (i=0;i<4;i++)begin
      tb_in=i;#10;
    end
  end
  initial begin
    $monitor("%b \t %b \t %b",tb_in,enable,tb_out);
  end
endmodule
  
