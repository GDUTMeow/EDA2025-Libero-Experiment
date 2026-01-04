module _74hc86(a1, a2, b1, b2, c1, c2, d1, d2, y1, y2, y3, y4);  // XOR Gate
    input a1, a2, b1, b2, c1, c2, d1, d2;
    output reg y1, y2, y3, y4;
    
    always
        @(a1 or a2 or b1 or b2 or c1 or c2 or d1 or d2)
        begin
            y1 <= a1 ^ a2;
            y2 <= b1 ^ b2;
            y3 <= c1 ^ c2;
            y4 <= d1 ^ d2;
        end
endmodule