module priority_encoder8_3_tb;
    reg [0:7] tb_a;
    wire [0:2] tb_out;
  
    priority_encoder8_3 dut (
        .a   (tb_a),
        .out (tb_out)
    );

    initial begin
        $display("Time\t Input (a)    \t Output (out)");
        $display("---------------------------------------");

        tb_a = 8'b10000000; #10;        
        tb_a = 8'b01000010; #10;       
        tb_a = 8'b00100000; #10;       
        tb_a = 8'b00010010; #10;
        tb_a = 8'b00001000; #10;
        tb_a = 8'b00000100; #10;
        tb_a = 8'b00000010; #10;
        tb_a = 8'b00000001; #10;
        $finish;
    end
    initial begin
        $monitor("%0dns\t b%b \t b%b", $time, tb_a, tb_out);
    end

endmodulem

odule priority_encoder8_3(
  input wire [0:7] a,
  output wire [0:2] out
);
  always @(*) begin
    case (a)
      a[7]:out=3'b111;
      a[6]:out=3'b110;
      a[5]:out=3'b101;
      a[4]:out=3'b100;
      a[3]:out=3'b011;
      a[2]:out=3'b010;
      a[1]:out=3'b001;
      a[0]:out=3'b000;
  end
endmodule