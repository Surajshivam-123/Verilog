module mux2_1(a,s,out);
  input wire [1:0]a;
  input wire s;
  output wire out;
  wire w1,w2,ns;
  not(ns,s);
  and(w1,a[0],ns);
  and(w2,a[1],s);
  or(out,w1,w2);
endmodule


module mux8_1(i,s,out);
  input wire [7:0]i;
  input wire [2:0]s;
  output wire out;
  wire [3:0]w0;
  wire [1:0]w1;
  mux2_1 m1(.a(i[1:0]),.s(s[0]),.out(w0[0]));
  mux2_1 m2(.a(i[3:2]),.s(s[0]),.out(w0[1]));
  mux2_1 m3(.a(i[5:4]),.s(s[0]),.out(w0[2]));
  mux2_1 m4(.a(i[7:6]),.s(s[0]),.out(w0[3]));
  mux2_1 m5(.a(w0[1:0]),.s(s[1]),.out(w1[0]));
  mux2_1 m6(.a(w0[3:2]),.s(s[1]),.out(w1[1]));
  mux2_1 m7(.a(w1),.s(s[2]),.out(out));
endmodule
