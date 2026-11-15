module t_ff(input t,clk,rst,output reg q);
  always@(negedge clk or negedge rst)begin
    if(!rst)
      q<=0;
    else if(t)
      q<=~q;
  end
endmodule

module async_counter(clk,rst,count);
  input clk,rst;
  output [2:0]count;
  t_ff ff0(1'b1,clk,rst,count[0]);
  t_ff ff1(1'b1,~count[0],rst,count[1]);
  t_ff ff2(1'b1,~count[1],rst,count[2]);
endmodule

module tb_async_up_counter; 
  reg clk,rst; 
  wire [2:0]count; 
  async_counter dut(clk,rst,count); 
  initial begin 
    clk=1'b0; 
    forever #5 clk=~clk; 
  end 
  initial begin 
      $dumpfile("waves.vcd"); 
      $dumpvars(0,tb_async_up_counter); 
  end 

  initial begin 
    $monitor("Time=%0t clk=%b rst=%b count=%b",$time,clk,rst,count);  

    rst=0; 
    #10 rst=1; 
    #80 $finish; 
  end 
endmodule 
