module mealy_101 (
    input  wire clk,
    input  wire rst,
    input  wire x,
    output reg  y
);

    parameter S0 = 2'b00, 
              S1 = 2'b01, 
              S2 = 2'b10; 

    reg [1:0] state, next_state;

    
    always @(posedge clk or negedge rst) begin
        if (!rst) 
            state <= S0;
        else 
            state <= next_state;
    end

   
    always @(*) begin
        // Default assignments
        next_state = state;
        y = 1'b0;

        case (state)
            S0: begin
                if (x) 
                    next_state = S1;
                else 
                    next_state = S0;
            end

            S1: begin
                if (x) 
                    next_state = S1; 
                else 
                    next_state = S2;
            end

            S2: begin
                if (x) begin 
                    next_state = S0; 
                    y = 1'b1;        
                end else begin 
                    next_state = S0; 
                end
            end

            default: begin
                next_state = S0;
                y = 1'b0;
            end
        endcase
    end

endmodule

module tb_mealy_101; 
  reg clk, rst, x; 
  wire y; 
 
  mealy_101 dut(clk, rst, x, y); 
 
  initial begin 
    clk = 0; 
    forever #5 clk = ~clk;
  end 
 
  initial begin 
    $monitor("Time=%0t | x=%b y=%b State=%b", $time, x, y, dut.state);  
 
    rst = 0; x = 0; 
    #12 rst = 1; 
    #8  x = 1;   
    #10 x = 1;   
    #10 x = 0;  
    #10 x = 1;   
    #10 x = 0;   
    #10 x = 1;   
    #10 x = 1;   
    #10 x = 0;   
    #10 x = 1;   
    #10 x = 0;   
    #10 x = 1;   
    #10 x = 1; 
    #10 $finish; 
  end 
endmodule
