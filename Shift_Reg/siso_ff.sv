module dff(input d,en,clk,rst,output reg q);
  always@(posedge clk or negedge rst)begin
    if(!rst)
      q<=1'b0;
    else if(en)
      q<=d;
   end
endmodule

module siso_ff(input s_in,en,clk,rst,output s_out);
  wire q0,q1,q2,q3;
  dff ff0(s_in,en,clk,rst,q3);
  dff ff1(q3,en,clk,rst,q2);
  dff ff2(q2,en,clk,rst,q1);
  dff ff3(q1,en,clk,rst,q0);
  assign s_out=q0;
endmodule


module siso_fftest;
  reg s_in, en, clk, rst;
  wire s_out;
  
  siso_ff dut(s_in, en, clk, rst, s_out);
  
  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, siso_fftest);
  end
  
  initial begin
    rst = 0; en = 0; s_in = 0; 
    #15 rst = 1; en = 1; 
    #10  s_in = 1; 
    #20 s_in = 0; 
    #20 s_in = 1; 
    #20 s_in = 1; 
    #20 s_in = 1; 
    #20 s_in = 0; 
    #20 s_in = 1; 
    #20 s_in = 1; 
    #20 $finish; 
  end
  
  initial begin
    $monitor("Time = %0t | clk = %b rst = %b en = %b s_in = %b | q3 = %b q2 = %b q1 = %b q0 = %b | s_out = %b",
             $time, clk, rst, en, s_in, dut.q3, dut.q2, dut.q1, dut.q0, s_out);
  end
endmodule
