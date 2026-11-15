module binary_to_bcd(
    input [7:0] bin_in,
    output [11:0] bcd_out
);

    wire [3:0] hundreds;
    wire [3:0] tens;
    wire [3:0] units;

    assign hundreds = bin_in / 100;
    assign tens     = (bin_in % 100) / 10;
    assign units    = bin_in % 10;

    assign bcd_out  = {hundreds, tens, units};

endmodule


module tb_binary_to_bcd_modulo;

    reg [7:0] bin_in;

    wire [11:0] bcd_out;

    binary_to_bcd_modulo uut (
        .bin_in(bin_in),
        .bcd_out(bcd_out)
    );

    initial begin
        $display("Time(ns)\tBinary Input\tDecimal\tBCD (Hundreds : Tens : Units)");
        $display("---------------------------------------------------------------");
        
        // Monitor changes
        $monitor("%0t\t\t%b\t%0d\t%b : %b : %b", 
                 $time, bin_in, bin_in, 
                 bcd_out[11:8], bcd_out[7:4], bcd_out[3:0]);

        // Test cases covering boundaries and typical values
        bin_in = 8'd0;   #10;
        bin_in = 8'd7;   #10;
        bin_in = 8'd15;  #10;
        bin_in = 8'd42;  #10;
        bin_in = 8'd99;  #10;
        bin_in = 8'd100; #10;
        bin_in = 8'd217; #10;
        bin_in = 8'd255; #10;

        $finish;
    end

endmodule