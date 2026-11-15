module siso_noff(input s_in,en,clk,rst,output wire s_out);
  reg [3:0]q;
  always@(posedge clk or negedge rst)begin
    if(!rst)
      q<=4'b0000;
    else if(en)
      q<={s_in,q[3:1]};
  end
  assign s_out=q[0];
endmodule

module siso_nofftest;
  reg s_in,en,clk,rst;
  wire s_out;
  siso_noff dut(s_in,en,clk,rst,s_out);
  
  initial begin
    clk=0;
    forever #10 clk=~clk;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,siso_nofftest);
  end
  initial begin
    rst = 0; en = 0; s_in = 0;
    #15 rst = 1; en = 1;
    s_in = 1;      // Sampled at t=30
    #20 s_in = 0;  // Sampled at t=50
    #20 s_in = 1;  // Sampled at t=70
    #20 s_in = 1;  // Sampled at t=90
    #20 s_in = 1;  // Sampled at t=110
    #20 s_in = 0;  // Sampled at t=130
    #20 s_in = 1;  // Sampled at t=150
    #20 s_in = 1;  // Sampled at t=170

    #20 rst = 0;
    #40 $finish;
  end
  initial begin
    $monitor("Time=%0t | RST=%b | Clk=%b | In=%b | Out=%b",
             $time, rst, clk, s_in,s_out);
  end
endmodule
