module cla_4bit(
    input  [3:0] a, b,
    input        cin,
    output [3:0] sum,
    output       G, P
);
    wire [3:0] g, p, c;

    assign g = a & b;     // Generate
    assign p = a ^ b;     // Propagate

    assign c[0] = cin;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & c[1]);
    assign c[3] = g[2] | (p[2] & c[2]);

    assign sum = p ^ c[3:0];

    // Group Generate and Propagate (for higher-level CLA)
    assign G = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
    assign P = p[3] & p[2] & p[1] & p[0];
endmodule
