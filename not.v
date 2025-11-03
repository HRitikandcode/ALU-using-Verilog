module not_gate(
    input [31:0]a,
    input en,
    output [31:0]result
);
   assign result = (~a) &  {32{en}};
   
endmodule