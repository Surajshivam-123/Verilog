//a-b
module half_subtractor(input a,
                       input b,
                       output sum,
                       output borrow
                      );
  xor(sum,a,b);
  and(borrow,~a,b);
endmodule
