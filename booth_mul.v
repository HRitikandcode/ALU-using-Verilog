module b_mul (
    input  [31:0] a,  // Multiplicand
    input  [31:0] b,  // Multiplier
    output [63:0] result
);
    reg signed [63:0] A, S, P;
    integer i;

    always @(*) begin
        // Initialize values
        A = { {32{a[31]}}, a };         // Sign-extend multiplicand
        S = { {32{~a[31]}}, (~a + 1'b1) }; // Two's complement (-A)
        P = { 32'b0, b, 1'b0 };         // Concatenate multiplier + extra bit for Booth encoding

        // Booth algorithm (32 iterations)
        for (i = 0; i < 32; i = i + 1) begin
            case (P[1:0])
                2'b01: P[64:33] = P[64:33] + A; // Add A
                2'b10: P[64:33] = P[64:33] + S; // Subtract A
                default: ; // 00 or 11 -> do nothing
            endcase
            // Arithmetic right shift by 1 bit
            P = { P[64], P[64:1] };
        end
    end

    assign result = P[64:1]; // 64-bit final product
endmodule
