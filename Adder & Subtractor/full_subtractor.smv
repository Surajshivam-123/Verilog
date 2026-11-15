// Write your modules here!
module full_subtractor(input a,input b,input bin,output diff,output borrow);
  wire w1,w2,w3;
  xor(w1,a,b);
  xor(diff,w1,bin);
  
  and(w2,bin,~w1);
  and(w3,~a,b);
  or(borrow,w2,w3);
endmodule
