module priority_encoder4_2(
  input wire [0:3]in,
  input wire enable,
  output reg [0:1]out
);
  int i=0;
  always @ (*) begin
    if(!enable) begin
      out=2'bxx;
    end
    else begin
      begin:my_loop
      for (i=0;i<4;i++)begin
        if(in[i]==1)begin
          out=3-i;
          disable my_loop;
        end
      end
      end
      if(i==4)begin
        out=2'bxx;
      end
    end
  end
endmodule


module test_bench_priority_encoder4_2;
  reg [0:3] tb_in;
  reg enable;
  wire [0:1] tb_out;
  int i;
  priority_encoder4_2 dut(tb_in,enable,tb_out);
  initial begin
    tb_in=1;
    enable=0;#10;
    for (i=0;i<16;i++)begin
      enable=1;
      tb_in=i;#10;
    end
  end
  initial begin
    $monitor("in = %b \t en = %b \t out = %b",tb_in,enable,tb_out);
  end
endmodule
