// 2x1 MUX
module mux2_1(input a,input b,input s,output op);
  wire w1,w2;
  and(w1,~s,a);
  and(w2,s,b);
  or(op,w1,w2);
endmodule
