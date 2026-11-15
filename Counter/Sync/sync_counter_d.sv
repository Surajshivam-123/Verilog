module dff(d,clk,rst,q);
  input d,clk,rst;
  output reg q;
  always@(posedge clk or negedge rst)begin
    if(!rst)
      q<=0;
    else
      q<=d;
  end
endmodule

module counter(clk,rst,count);
  input clk,rst;
  output [2:0]count;
  
  wire d0,d1,d2;
  assign d0=~count[0];
  assign d1=count[0]^count[1];
  assign d2=(count[0]&count[1])^count[2];
  dff ff0(d0,clk,rst,count[0]);
  dff ff1(d1,clk,rst,count[1]);
  dff ff2(d2,clk,rst,count[2]);
endmodule

module tb_sync_up_counter; 
  reg clk,rst; 
  wire [2:0]count; 
  counter dut(clk,rst,count); 
  initial begin 
  clk=0; 
  forever #5 clk=~clk; 
  end 
  initial begin 
  $dumpfile("waves.vcd"); 
  $dumpvars(1); 
  end 
  initial begin 
    $monitor("Time=%0t clk=%b rst=%b count=%b",$time,clk,rst,count); 
    rst=0; 
    #10 rst=1; 
    #80 $finish; 
  end
endmodule