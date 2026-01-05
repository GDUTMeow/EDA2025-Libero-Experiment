module top_module(
    input Rst, Clk, en,
    output R1, R2, Y1, Y2, G1, G2,
    output [7:0] Seg,
    output [3:0] Sel
);
    // Instantiate Traffic Light Logic
    two_lights u_two_lights (
        .Clk (Clk),
        .Rst (Rst),
        .en  (en),
        .R1(R1), .R2(R2), .Y1(Y1), .Y2(Y2), .G1(G1), .G2(G2)
    );

    // Instantiate Timer Display Logic
    timer u_timer (
        .Clk (Clk),
        .Rst (Rst),
        .en  (en),
        .Seg (Seg),
        .Sel (Sel)
    );
endmodule