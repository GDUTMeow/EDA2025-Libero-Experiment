`timescale 1ns/1ns

module test_74hc04;
    reg a, b, c, d, e, f;
    wire y1, y2, y3, y4, y5, y6;

_74hc04 bench(a, b, c, d, e, f, y1, y2, y3, y4, y5, y6);
    initial begin
        a = 0; b = 0; c = 0; d = 0; e = 0; f = 0;
        #5 a = 1;
        #5 a = 0; b = 1;
        #5 b = 0; c = 1;
        #5 c = 0; d = 1;
        #5 d = 0; e = 1;
        #5 e = 0; f = 1;
        #5;
    end
    always @(*) begin
        $display("[*] [74HC04] time = %t: a = %b, y1 = %b; b = %b, y2 = %b; c = %b, y3 = %b; d = %b, y4 = %b; e = %b, y5 = %b; f = %b, y6 = %b",
                $time, a, y1, b, y2, c, y3, d, y4, e, y5, f, y6);   // In order to display both module at the same time, cannot use $monitor.
    end
endmodule