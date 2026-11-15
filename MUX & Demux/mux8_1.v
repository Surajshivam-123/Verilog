// 8X1 MUX
module mux8_1(a,s,y);
  input wire [7:0]a;
  input wire [2:0]s;
  output y;
  not(n1,s[0]);
  not(n2,s[1]);
  not(n3,s[2]);
  wire [13:0]w;
  //2X1 MUX
  and(w[0],a[0],n1,n2,n3);
  and(w[1],a[1],n1,n2,s[2]);
  or(w[8],w[0],w[1]);
  //2X1 MUX
  and(w[2],a[2],n1,s[1],n3);
  and(w[3],a[3],n1,s[1],s[2]);
  or(w[9],w[2],w[3]);
  //2X1 MUX
  and(w[4],a[4],s[0],n2,n3);
  and(w[5],a[5],s[0],n2,s[2]);
  or(w[10],w[4],w[5]);
  //2X1 MUX
  and(w[6],a[6],s[0],s[1],n3);
  and(w[7],a[7],s[0],s[1],s[2]);
  or(w[11],w[6],w[7]);
  
  //2X1 MUX
  or(w[12],w[8],w[9]);
  or(w[13],w[10],w[11]);
  
  or(y,w[12],w[13]);
endmodule
