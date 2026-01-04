module _74hc04(a, b, c, d, e, f, y1, y2, y3, y4, y5, y6);    // NOT Gate
    input a, b, c, d, e, f;
    output reg y1, y2, y3, y4, y5, y6;
    
    always
        @(a, b, c, d, e, f)
        begin
            y1 <= ~a;
            y2 <= ~b;
            y3 <= ~c;
            y4 <= ~d;
            y5 <= ~e;
            y6 <= ~f;
        end
endmodule
