module and_gate(
    input [31:0]           a,
    input [31:0]           b,
    input                     en,
    output reg[31:0]    result
);
    always @(*) begin
       assign result = (a & b) & {32{en}};
    end
endmodule