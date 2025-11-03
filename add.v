module cla_32bit_adder(
    input  [31:0] a, b,
    input         cin,
    output [31:0] sum,
    output        cout
);
    wire [7:0] gG, gP;      // group generate and propagate
    wire [8:0] carry;       // carry between 4-bit blocks
    assign carry[0] = cin;

    // Instantiate 8 CLA4 blocks
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : CLA_BLOCKS
            cla_4bit cla_block (
                .a   (a[i*4 +: 4]),
                .b   (b[i*4 +: 4]),
                .cin (carry[i]),
                .sum (sum[i*4 +: 4]),
                .G   (gG[i]),
                .P   (gP[i])
            );

            // Compute next block carry
            assign carry[i+1] = gG[i] | (gP[i] & carry[i]);
        end
    endgenerate

    assign cout = carry[8];

endmodule
