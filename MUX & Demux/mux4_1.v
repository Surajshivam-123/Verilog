module mux4_1(a,s,op);
  input wire [3:0]a;
  input wire [1:0]s;
  output op;
  wire w1,w2,w3,w4;
  and(w1,~s[0],~s[1],a[0]);
  and(w2,s[0],~s[1],a[1]);
  and(w3,~s[0],s[1],a[2]);
  and(w4,s[0],s[1],a[3]);
  or(op,w1,w2,w3,w4);
endmodule
