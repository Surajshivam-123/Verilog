module jk_ff(input j,k,clk,rst,output reg q,output q_bar);
  assign q_bar=~q;
  always@(negedge clk or negedge rst)begin
    if(!rst)
      q<=0;
    else
      case ({j,k})
        2'b00:q<=q;
        2'b01:q<=1'b0;
        2'b10:q<=1'b1;
        2'b11:q<=~q;
      endcase
  end
endmodule
        
module async_up_counter(input clk,rst,output [2:0]count);
  wire q_b0,q_b1,q_b2;
  jk_ff ff0(1'b1,1'b1,clk,rst,count[0],q_b0);
  jk_ff ff1(1'b1,1'b1,count[0],rst,count[1],q_b1);
  jk_ff ff2(1'b1,1'b1,count[1],rst,count[2],q_b2);
endmodule

module tb_async_up_counter; 
  reg clk,rst; 
  wire [2:0] count; 
 
  async_up_counter dut(clk,rst,count); 
 
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