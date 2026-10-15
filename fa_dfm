module fa_dfma(a,b,c,sum,carry);
  input a,b,c;
  output wire sum,carry;
  assign sum=a?(b==c):(b!=c);
  assign carry=a==1?(b==1 | c==1):b == 1?c==1:0;
endmodule
