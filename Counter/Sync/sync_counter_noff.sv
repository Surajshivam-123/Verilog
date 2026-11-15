module counter(clk,rst,count);
  input clk,rst;
  output reg [2:0]count;
  always@(posedge clk or negedge rst)begin
    if(!rst)
      count<=3'b000;
    else
      count<=count+1'b1;
  end
endmodule

module counter_test;
 	reg clk,rst;
  wire [2:0]count;
  counter dut(clk,rst,count);
  initial clk=0; 
  always #5 clk=~clk; 
 
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