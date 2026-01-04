module top_module(    
    // Pins of 74HC04
    input not_a, not_b, not_c, not_d, not_e, not_f,
    output not_y1, not_y2, not_y3, not_y4, not_y5, not_y6,

    // Pins of 74HC86
    input xor_a1, xor_a2, xor_b1, xor_b2, xor_c1, xor_c2, xor_d1, xor_d2,
    output xor_y1, xor_y2, xor_y3, xor_y4
);

    // Initialize instances of 74HC04 and 74HC86
    _74hc04 u_74hc04 (
        .a (not_a),
        .b (not_b),
        .c (not_c),
        .d (not_d),
        .e (not_e),
        .f (not_f),
        .y1 (not_y1),
        .y2 (not_y2),
        .y3 (not_y3),
        .y4 (not_y4),
        .y5 (not_y5),
        .y6 (not_y6)
    );

    _74hc86 u_74hc86 (
        .a1 (xor_a1),
        .a2 (xor_a2),
        .b1 (xor_b1),
        .b2 (xor_b2),
        .c1 (xor_c1),
        .c2 (xor_c2),
        .d1 (xor_d1),
        .d2 (xor_d2),
        .y1 (xor_y1),
        .y2 (xor_y2),
        .y3 (xor_y3),
        .y4 (xor_y4)
    );

endmodule