`timescale 1 ns/100 ps
// Version: v11.9 11.9.0.4
// File used only for Simulation


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

    wire a_c, b_c, c_c, \y_c[0] , \c_pad/U0/NET1 , \b_pad/U0/NET1 , 
        \y_pad[0]/U0/NET1 , \y_pad[0]/U0/NET2 , VCC, \a_pad/U0/NET1 , 
        GND, AFLSDF_VCC, AFLSDF_GND;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign AFLSDF_GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign AFLSDF_VCC = VCC_power_net1;
    
    IOPAD_IN \c_pad/U0/U0  (.PAD(c), .Y(\c_pad/U0/NET1 ));
    IOIN_IB \b_pad/U0/U1  (.YIN(\b_pad/U0/NET1 ), .Y(b_c));
    IOPAD_IN \a_pad/U0/U0  (.PAD(a), .Y(\a_pad/U0/NET1 ));
    IOIN_IB \a_pad/U0/U1  (.YIN(\a_pad/U0/NET1 ), .Y(a_c));
    IOPAD_TRI \y_pad[0]/U0/U0  (.D(\y_pad[0]/U0/NET1 ), .E(
        \y_pad[0]/U0/NET2 ), .PAD(y[0]));
    IOTRI_OB_EB \y_pad[0]/U0/U1  (.D(\y_c[0] ), .E(VCC), .DOUT(
        \y_pad[0]/U0/NET1 ), .EOUT(\y_pad[0]/U0/NET2 ));
    IOPAD_IN \b_pad/U0/U0  (.PAD(b), .Y(\b_pad/U0/NET1 ));
    ZOR3 \y[0]  (.A(b_c), .B(c_c), .C(a_c), .Y(\y_c[0] ));
    IOIN_IB \c_pad/U0/U1  (.YIN(\c_pad/U0/NET1 ), .Y(c_c));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
