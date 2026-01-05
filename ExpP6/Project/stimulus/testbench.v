`timescale 1ns/1ns

module testdecoder2x4;  // Test bench name shoule be put into Project -> Project Settings -> Simulation options -> DO file -> Testbench module name
    reg pa, pb, pen;
    wire [3:0] py;

decoder2x4 ul(pa, pb, pen, py); // Need to be put into Project -> Project Settings -> Simulation options -> DO file -> Top level instance name
    initial
        begin
            pa = 0;
            pb = 0;
            pen = 0;
            #5 pen = 1;
            #10 pa = 1;
            #5 pb = 1;
            #5 pa = 0;
            #10 pb = 0;
        end

initial
    $monitor("time=%t, a=%b, b=%b, en=%b, y=%b", $time, pa, pb, pen, py);
endmodule
