`timescale 1ns/1ns

// `include "../hdl/74hc138.v"
// `include "../hdl/74hc153.v"
// `include "../hdl/74hc283.v"
// `include "../hdl/top_module.v"

module testall_bench;
    // 74HC138
    reg d_a0, d_a1, d_a2;
    reg d_e1, d_e2, d_e3;
    wire d_y0, d_y1, d_y2, d_y3, d_y4, d_y5, d_y6, d_y7;

    // 74HC153
    reg s_s0, s_s1;
    reg s_e1, s_e2;
    reg s_a0, s_a1, s_a2, s_a3;
    reg s_b0, s_b1, s_b2, s_b3;
    wire s_y1, s_y2;

    // 74HC283
    reg a_a0, a_a1, a_a2, a_a3;
    reg a_b0, a_b1, a_b2, a_b3;
    reg a_cin;
    wire a_s0, a_s1, a_s2, a_s3;
    wire a_cout;

    // // Initialize modules for unit test
    // _74hc138 u_74hc138 (d_a0, d_a1, d_a2, d_e1, d_e2, d_e3, d_y0, d_y1, d_y2, d_y3, d_y4, d_y5, d_y6, d_y7);
    // _74hc153 u_74hc153 (s_s0, s_s1, s_e1, s_e2, s_a0, s_a1, s_a2, s_a3, s_b0, s_b1, s_b2, s_b3, s_y1, s_y2);
    // _74hc283 u_74hc283 (a_a0, a_a1, a_a2, a_a3, a_b0, a_b1, a_b2, a_b3, a_cin, a_s0, a_s1, a_s2, a_s3, a_cout);

    top_module bench (
        // 74HC138 Ports
        .d_a0(d_a0), .d_a1(d_a1), .d_a2(d_a2),
        .d_e1(d_e1), .d_e2(d_e2), .d_e3(d_e3),
        .d_y0(d_y0), .d_y1(d_y1), .d_y2(d_y2), .d_y3(d_y3),
        .d_y4(d_y4), .d_y5(d_y5), .d_y6(d_y6), .d_y7(d_y7),

        // 74HC153 Ports
        .s_s0(s_s0), .s_s1(s_s1),
        .s_e1(s_e1), .s_e2(s_e2),
        .s_a0(s_a0), .s_a1(s_a1), .s_a2(s_a2), .s_a3(s_a3),
        .s_b0(s_b0), .s_b1(s_b1), .s_b2(s_b2), .s_b3(s_b3),
        .s_y1(s_y1), .s_y2(s_y2),

        // 74HC283 Ports
        .a_a0(a_a0), .a_a1(a_a1), .a_a2(a_a2), .a_a3(a_a3),
        .a_b0(a_b0), .a_b1(a_b1), .a_b2(a_b2), .a_b3(a_b3),
        .a_cin(a_cin),
        .a_s0(a_s0), .a_s1(a_s1), .a_s2(a_s2), .a_s3(a_s3),
        .a_cout(a_cout)
    );

    // Testbench logic
    initial begin
        $display("[+] Starting testbench...");
        // test for 74hc138
        // initialize all inputs
        d_a0 = 0; d_a1 = 0; d_a2 = 0;
        d_e1 = 0; d_e2 = 0; d_e3 = 0;
        #5 d_e1 = 1;
        #5 d_e2 = 1;
        #5 d_e3 = 0;
        #5 d_e1 = 0; d_e2 = 0; d_e3 = 1; d_a0 = 0; d_a1 = 0; d_a2 = 0;  // LLH -> enable
        #5 d_a0 = 1;
        #5 d_a0 = 0; d_a1 = 1;
        #5 d_a0 = 1;
        #5 d_a0 = 0; d_a1 = 0; d_a2 = 1;
        #5 d_a0 = 1;
        #5 d_a0 = 0; d_a1 = 1;
        #5 d_a0 = 1;
        #5;

        // test for 74hc153
        // initialize all inputs
        #5 s_e1 = 1; s_e2 = 1; s_s0 = 0; s_s1 = 0;  // e1 = e2 = 1 -> both output disabled -> y1 = y2 = 0
        #5 s_e1 = 0; // enable the output of channel a
        #5 s_s0 = 0; s_s1 = 0; // select a0
        s_a0 = 0;
        #5 s_a0 = 1;
        #5 s_s0 = 1; s_s1 = 0; // select a1
        s_a1 = 0;
        #5 s_a1 = 1;
        #5 s_s0 = 0; s_s1 = 1; // select a2
        s_a2 = 0;
        #5 s_a2 = 1;
        #5 s_s0 = 1; s_s1 = 1; // select a3
        s_a3 = 0;
        #5 s_a3 = 1;
        #5 s_e1 = 1; s_e2 = 0; // switch to channel b
        #5 s_s0 = 0; s_s1 = 0; // select b0
        s_b0 = 0;
        #5 s_b0 = 1;
        #5 s_s0 = 1; s_s1 = 0; // select b1
        s_b1 = 0;
        #5 s_b1 = 1;
        #5 s_s0 = 0; s_s1 = 1; // select b2
        s_b2 = 0;
        #5 s_b2 = 1;
        #5 s_s0 = 1; s_s1 = 1; // select b3
        s_b3 = 0;
        #5 s_b3 = 1;
        #5;

        // test for 74hc283
        // initialize all inputs
        a_a0 = 0; a_a1 = 0; a_a2 = 0; a_a3 = 0;
        a_b0 = 0; a_b1 = 0; a_b2 = 0; a_b3 = 0;
        a_cin = 0;

        // 1101 + 1001 + 0 = 10110
        #5 a_cin = 0; a_a3 = 1; a_a2 = 1; a_a1 = 0; a_a0 = 1; // A = 1101
        a_b3 = 1; a_b2 = 0; a_b1 = 0; a_b0 = 1; // B = 1001
        
        // 0111 + 0101 + 1 = 01101
        #5 a_cin = 1; a_a3 = 0; a_a2 = 1; a_a1 = 1; a_a0 = 1; // A = 0111
        a_b3 = 0; a_b2 = 1; a_b1 = 0; a_b0 = 1; // B = 0101
        #5;

        $display("[+] Testbench finished.");
    end

    // display result of 74hc138
    always @(d_a0 or d_a1 or d_a2 or d_e1 or d_e2 or d_e3) begin
        #1 $display("[*] [74HC138] e1 = %b, e2 = %b, e3 = %b, {a2, a1, a0} = %b%b%b -> {y7, y6, y5, y4, y3, y2, y1, y0} = %b%b%b%b%b%b%b%b",
            d_e1, d_e2, d_e3,
            d_a2, d_a1, d_a0,
            d_y7, d_y6, d_y5, d_y4, d_y3, d_y2, d_y1, d_y0
        );
    end

    // display result of 74hc153
    always @(s_s0 or s_s1 or s_e1 or s_e2 or s_a0 or s_a1 or s_a2 or s_a3 or s_b0 or s_b1 or s_b2 or s_b3) begin
        #1 $display("[*] [74HC153] e1 = %b, e2 = %b, {s1, s0} = %b%b, {a0, a1, a2, a3} = %b%b%b%b, {b0, b1, b2, b3} = %b%b%b%b -> y1 = %b, y2 = %b",
            s_e1, s_e2,
            s_s1, s_s0,
            s_a0, s_a1, s_a2, s_a3,
            s_b0, s_b1, s_b2, s_b3,
            s_y1, s_y2
        );
    end

    // display result of 74hc283
    always @(a_a0 or a_a1 or a_a2 or a_a3 or a_b0 or a_b1 or a_b2 or a_b3 or a_cin) begin
        #1 $display("[*] [74HC283] {a_a0, a_a1, a_a2, a_a3} = %b%b%b%b, {a_b0, a_b1, a_b2, a_b3} = %b%b%b%b, Cin = %b -> Sum = %b%b%b%b, Cout = %b",
            a_a3, a_a2, a_a1, a_a0,
            a_b3, a_b2, a_b1, a_b0,
            a_cin,
            a_s3, a_s2, a_s1, a_s0,
            a_cout
        );
    end


endmodule