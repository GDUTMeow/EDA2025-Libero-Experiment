`timescale 1 ns/100 ps
// Version: v11.9 11.9.0.4


module all(
       a,
       b,
       c,
       y
    );
input  a;
input  b;
input  c;
output [0:0] y;

    wire GND, VCC, a_c, b_c, c_c, \y_c[0] ;
    
    ZOR3 \y[0]  (.A(b_c), .B(c_c), .C(a_c), .Y(\y_c[0] ));
    INBUF c_pad (.PAD(c), .Y(c_c));
    INBUF b_pad (.PAD(b), .Y(b_c));
    OUTBUF \y_pad[0]  (.D(\y_c[0] ), .PAD(y[0]));
    VCC VCC_i (.Y(VCC));
    GND GND_i (.Y(GND));
    INBUF a_pad (.PAD(a), .Y(a_c));
    
endmodule
