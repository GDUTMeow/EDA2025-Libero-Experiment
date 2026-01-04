`timescale 1ns/1ns

module test_74hc86;
    reg a1, a2, b1, b2, c1, c2, d1, d2;
    wire y1, y2, y3, y4;

_74hc86 bench(a1, a2, b1, b2, c1, c2, d1, d2, y1, y2, y3, y4);
    initial begin
        a1 = 0; a2 = 0;
        b1 = 0; b2 = 0;
        c1 = 0; c2 = 0;
        d1 = 0; d2 = 0;
        #5;     // initial with both 0, which should produce 0 ^ 0 = 0
        #5 a1 = 1; b1 = 1; c1 = 1; d1 = 1;  // 0 ^ 1 = 1
        #5 a1 = 0; b1 = 0; c1 = 0; d1 = 0; a2 = 1; b2 = 1; c2 = 1; d2 = 1;  // 1 ^ 0 = 1
        #5 a1 = 1; b1 = 1; c1 = 1; d1 = 1;  // 1 ^ 1 = 0
    end
    always @(*) begin
        $display("[*] [74HC86] time = %t: a1 = %b, a2 = %b, y1 = %b; b1 = %b, b2 = %b, y2 = %b; c1 = %b, c2 = %b, y3 = %b; d1 = %b, d2 = %b, y4 = %b", 
        $time, a1, a2, y1, b1, b2, y2, c1, c2, y3, d1, d2, y4); // In order to display both module at the same time, cannot use $monitor.
    end
endmodule
