module sr(input s,r,clk,rst,output reg q,output wire q_bar);
  always @(posedge clk or negedge rst)begin
    if(!rst)begin
      q<=0;
    end
    else if(s & r)begin
      q<=1'bx;
    end
    else begin
      q<=s|(~r & q);
    end
  end
  assign q_bar=~q;
endmodule


module sr_test;
  reg s,r,clk,rst;
  wire q,q_bar;
  sr dut(s,r,clk,rst,q,q_bar);
  initial begin
    clk=0;
    forever #10 clk=~clk;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,sr_test);
  end
  initial begin
    rst=0;
    #15 rst=1;
    #10 s=1; r=0; 
    #20 s=0; r=0; 
    #20 s=1; r=0; 
    #20 s=1; r=1; 
    #10 rst=0;
    #20 $finish;
  end
  initial begin
    $monitor("Time=%0t | RST=%b | Clk=%b | J=%b | K=%b | Q=%b | Q_bar=%b",
             $time, rst, clk, s, r, q, q_bar);
  end
endmodule