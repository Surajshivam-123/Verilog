module pipo(p_in,en,clk,rst,p_out);
  input [3:0]p_in;
  input en,clk,rst;
  output reg [3:0]p_out;
  always@(posedge clk or negedge rst)begin
    if(!rst)
      p_out<=4'b0000;
    else if(en)
      p_out<=p_in;
      
  end
endmodule

module pipo_test;
  reg [3:0]p_in;
  reg en,clk,rst;
  wire [3:0]p_out;
  
  pipo dut(p_in,en,clk,rst,p_out);
  initial begin
    clk=0;
    forever #10 clk=~clk;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  initial begin
    rst=0;en=0;
    #15 rst=1;en=1;
    #20 p_in=4'b0101;
    #20 p_in=4'b0001;
    #20 p_in=4'b1110;
    #20 p_in=4'b1100;
    #20 rst=0;
    #20$finish;
  end
  initial begin
    $monitor("Time=%t CLK=%b EN=%b RST=%b IN=%b , OUT=%b",$time,clk,en,rst,p_in,p_out);
  end
endmodule
