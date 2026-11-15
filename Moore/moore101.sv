module moore_101 (
    input clk,
    input rst,
    input x,
    output reg y
);

    reg [1:0] state, next_state;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    always @(posedge clk or negedge rst) begin
        if (!rst)
            state <= S0;
        else
            state <= next_state;
    end
    always @(*) begin
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
                if (x)
                    next_state = S3;
                else
                    next_state = S0;
            end
            S3: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            default: begin
                next_state = S0;
            end
        endcase
    end
    always @(*) begin
        case (state)
            S3:      y = 1'b1;
            default: y = 1'b0;
        endcase
    end

endmodule

module tb_moore_101; 
  reg clk,rst,x; 
  wire y; 
 
  moore_101 dut(clk,rst,x,y); 
 
  initial begin 
    clk=0; 
    forever #5 clk=~clk; 
  end 
 
  initial begin 
    $monitor("Time=%0t | x=%b y=%b State=%b", $time, x, y, dut.state);   
 
    rst=0;x=0; 
    #12 rst=1; 
    #8 x=1; 
    #10 x=1; 
    #10 x=0; 
    #10 x=1; 
    #10 x=0; 
    #10 x=1; 
    #10 x=1; 
    #10 x=0; 
    #10 x=1; 
    #10 x=0; 
    #10 x=1; 
    #10 x=1; 
    #10 $finish; 
end 
endmodule