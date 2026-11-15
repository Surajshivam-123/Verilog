//1X4 Demultiplexer
module demux1_4(x,s,y);
  output wire [3:0]y;
  input wire [1:0]s;
  input x;
  not(n1,s[0]);
  not(n2,s[1]);
  and(y[0],n1,n2,x);
  and(y[1],s[0],n2,x);
  and(y[2],n1,s[1],x);
  and(y[3],s[0],s[1],x);
endmodule
