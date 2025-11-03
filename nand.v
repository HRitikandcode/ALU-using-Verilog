module nand_gate(
    input [31:0]a,b,
    input en,
    output [31:0]result
);
   assign result = (~(a & b)) &  {32{en}};
endmodule