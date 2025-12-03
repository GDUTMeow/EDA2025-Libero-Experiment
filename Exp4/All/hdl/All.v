module AllModule(a, b, c, y);
    input a, b, c;
    output reg [0:0] y;
    always
        @(a or b or c)
        begin
            y[0] <= ((a && b && c) || (~a && ~b && ~c));
        end
endmodule
