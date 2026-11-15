// Write your modules here!
module full_adder_using_nand_gate(a,b,c,sum,carry);
  input a,b,c;
  output sum,carry;
  wire w1,w2,w3,w4,w5,w6,w7,w8;
  
  nand(w1,a,b);
  nand(w2,w1,a);
  nand(w3,w1,b);
  nand(w4,w2,w3);
  nand(w5,w4,c);
  nand(w6,w4,w5);
  nand(w7,w5,c);
  nand(sum,w6,w7);
  
  nand(w8,a,b);
  nand(carry,w5,w8);
  
endmodule
