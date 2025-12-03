`timescale 1ns/1ns

module testAll;
    reg a, b, c;
    wire y;

AllModule plat(a, b, c, y);
    initial
        begin
            a = 0;
            b = 0;
            c = 0;
            #5 c = 1;
            #5 b = 1; c = 0;
            #5 c = 1;
            #5 a = 1; b = 0; c = 0;
            #5 c = 1;
            #5 b = 1; c = 0;
            #5 c = 1;
        end

initial
    $monitor("time = %t, a = %b, b = %b, c = %b, y = %b", $time, a, b, c, y);
endmodule