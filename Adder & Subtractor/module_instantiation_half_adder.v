module half_adder(a,b,s,c);
  input wire a,b;
  output wire s,c;
  
  xor x1(s,a,b);
  and a1(c,a,b);
endmodule

module full_adder(a,b,cin,sum,cout);
  input wire a,b,cin;
  output sum,cout;
  wire ws,wc1,wc2;
  
  half_adder h1(a,b,ws,wc1);
  //half_adder h1(.a(a),.b(b),.s(ws),.c(wc1));
  half_adder h2(ws,cin,sum,wc2);
  //half_adder h2(.a(ws),.b(cin),.s(sum),.c(wc2));
  or o1(cout,wc1,wc2);
endmodule