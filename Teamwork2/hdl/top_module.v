module top_module(
    // d -> decoder, marked as 74hc138 serial
    input d_a0, d_a1, d_a2,     // 3 lines input for decoder
    input d_e1, d_e2, d_e3,     // 3 enable inputs for decoder
    output d_y0, d_y1, d_y2, d_y3, d_y4, d_y5, d_y6, d_y7, // 8 lines output for decoder
    // s -> selector, marked as 74hc153 serial
    input s_s0, s_s1,           // 2 lines input for selector
    input s_e1, s_e2,           // 2 channel enable input for selector
    input s_a0, s_a1, s_a2, s_a3, // 4 lines input for channel a of selector
    input s_b0, s_b1, s_b2, s_b3, // 4 lines input for channel b of selector
    output s_y1, s_y2,          // 2 lines output for selector
    // a -> adder, marked as 74hc283 serial
    input a_a0, a_a1, a_a2, a_a3,    // 4 bits input A for adder
    input a_b0, a_b1, a_b2, a_b3,    // 4 bits input B for adder
    input a_cin,                   // carry input for adder
    output a_s0, a_s1, a_s2, a_s3, // 4 bits sum output for adder
    output a_cout                  // carry output for adder
);

    // Initialize instances of 74HC138, 74HC153 and 74HC283
    _74hc138 u_74hc138 (
        .a0 (d_a0),
        .a1 (d_a1),
        .a2 (d_a2),
        .e1 (d_e1),
        .e2 (d_e2),
        .e3 (d_e3),
        .y0 (d_y0),
        .y1 (d_y1),
        .y2 (d_y2),
        .y3 (d_y3),
        .y4 (d_y4),
        .y5 (d_y5),
        .y6 (d_y6),
        .y7 (d_y7)
    );

    _74hc153 u_74hc153 (
        .s0 (s_s0),
        .s1 (s_s1),
        .e1 (s_e1),
        .e2 (s_e2),
        .a0 (s_a0),
        .a1 (s_a1),
        .a2 (s_a2),
        .a3 (s_a3),
        .b0 (s_b0),
        .b1 (s_b1),
        .b2 (s_b2),
        .b3 (s_b3),
        .y1 (s_y1),
        .y2 (s_y2)
    );

    _74hc283 u_74hc283 (
        .a0 (a_a0),
        .a1 (a_a1),
        .a2 (a_a2),
        .a3 (a_a3),
        .b0 (a_b0),
        .b1 (a_b1),
        .b2 (a_b2),
        .b3 (a_b3),
        .cin (a_cin),
        .s0 (a_s0),
        .s1 (a_s1),
        .s2 (a_s2),
        .s3 (a_s3),
        .cout (a_cout)
    );

endmodule