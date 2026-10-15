// Write your modules here!
module full_adder_using_basic_gate(a,b,c,sum,carry);
  input a,b,c;
  output sum,carry;
  wire w1,w2,w3,w4,w5,w6,w7;
  and(w1,~a,~b,c);
  and(w2,~a,b,~c);
  and(w3,a,~b,~c);
  and(w4,a,b,c);
  or(sum,w1,w2,w3,w4);
  
  and(w5,~a,b,c);
  and(w6,a,~b,c);
  and(w7,a,b,~c);
  or(carry,w5,w6,w7,w4);
  
endmodule
