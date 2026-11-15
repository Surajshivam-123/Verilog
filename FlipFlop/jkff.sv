module jk(input j,k,rst,clk,output reg q,output wire q_bar);
  always@(posedge clk or negedge rst)begin
    if(!rst)begin
      q<=0;
    end
    else begin
      q<=(j&~q)|(~k&q);
    end
  end
  assign q_bar=~q;
endmodule
    
module jk_test;
  reg j, k, rst, clk;
  wire q, q_bar;

  jk dut (
      .j(j),
      .k(k),
      .rst(rst),
      .clk(clk),
      .q(q),
      .q_bar(q_bar)
  );

  // Clock generation (20ns period)
  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end

  // Required for EPWave to capture signals
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, jk_test);
  end

  // Stimulus
  initial begin
    rst = 0;  
    #15 rst = 1;             
    #10 j = 1; k = 0;        // Set
    #20 j = 0; k = 0;        // Hold
    #20 j = 0; k = 1;        // Reset
    #20 j = 1; k = 1;        // Toggle
    #20 j = 1; k = 1;        // Toggle again
    #20 j = 1; k = 1; 
    #10 rst = 0;
    #20 $finish;
  end

  initial begin
    $monitor("Time=%0t | RST=%b | Clk=%b | J=%b | K=%b | Q=%b | Q_bar=%b",
             $time, rst, clk, j, k, q, q_bar);
  end
endmodule
