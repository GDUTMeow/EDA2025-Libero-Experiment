module decoder2x4(a, b, en, y);
    input a, b, en;
    output reg [3:0] y;
    reg af, bf;

always
    @(a or b or en)
    begin
        af = ~a;
        bf = ~b;
        y[0] <= ~(af & bf & en);
        y[1] <= ~(af & b & en);
        y[2] <= ~(a & af & en);
        y[3] <= ~(a & b & en);
    end
endmodule