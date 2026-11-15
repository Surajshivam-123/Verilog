module bcd_to_binary_3digit (
    input [11:0] bcd_in,    
    output [9:0] bin_out   
);

    wire [3:0] hundreds = bcd_in[11:8];
    wire [3:0] tens     = bcd_in[7:4];
    wire [3:0] units    = bcd_in[3:0];

    assign bin_out = (hundreds * 7'd100) + (tens * 4'd10) + units;

endmodule