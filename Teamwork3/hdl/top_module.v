module top_module(
    input Rst, Clk, en,    // Clock input (1kHz), Reset input and Enable input
    output R1, R2, Y1, Y2, G1, G2
);

    wire clk_1s;
    _1s_clock u_1s_clock (
        .Rst (Rst),
        .Clk (Clk),
        .Cout (clk_1s)
    );  // Convert 1kHz clock to 1Hz clock

    two_lights u_two_lights (
        .Clk (Clk),
        .Rst (Rst),
        .en (en),
        .tick_1s (clk_1s),
        .R1 (R1),
        .R2 (R2),
        .Y1 (Y1),
        .Y2 (Y2),
        .G1 (G1), 
        .G2 (G2)
    );

endmodule