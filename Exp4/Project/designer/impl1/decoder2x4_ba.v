`timescale 1 ns/100 ps
// Version: v11.9 11.9.0.4
// File used only for Simulation


module decoder2x4(
       a,
       b,
       en,
       y
    );
input  a;
input  b;
input  en;
output [3:0] y;

    wire \y_pad_RNO[3]_net_1 , \y_pad_RNO[0]_net_1 , 
        \y_pad_RNO[1]_net_1 , un7_y_net_1, a_c, b_c, en_c, 
        \y_pad[3]/U0/NET1 , \y_pad[3]/U0/NET2 , \b_pad/U0/NET1 , 
        \a_pad/U0/NET1 , \y_pad[2]/U0/NET1 , \y_pad[2]/U0/NET2 , 
        \y_pad[0]/U0/NET1 , \y_pad[0]/U0/NET2 , \en_pad/U0/NET1 , 
        \y_pad[1]/U0/NET1 , \y_pad[1]/U0/NET2 , VCC, GND, AFLSDF_VCC, 
        AFLSDF_GND;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign AFLSDF_GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign AFLSDF_VCC = VCC_power_net1;
    
    OR3C \y_pad_RNO[3]  (.A(b_c), .B(en_c), .C(a_c), .Y(
        \y_pad_RNO[3]_net_1 ));
    IOIN_IB \a_pad/U0/U1  (.YIN(\a_pad/U0/NET1 ), .Y(a_c));
    OR3B un7_y (.A(en_c), .B(a_c), .C(b_c), .Y(un7_y_net_1));
    IOPAD_IN \en_pad/U0/U0  (.PAD(en), .Y(\en_pad/U0/NET1 ));
    IOPAD_IN \b_pad/U0/U0  (.PAD(b), .Y(\b_pad/U0/NET1 ));
    IOPAD_TRI \y_pad[1]/U0/U0  (.D(\y_pad[1]/U0/NET1 ), .E(
        \y_pad[1]/U0/NET2 ), .PAD(y[1]));
    IOPAD_TRI \y_pad[0]/U0/U0  (.D(\y_pad[0]/U0/NET1 ), .E(
        \y_pad[0]/U0/NET2 ), .PAD(y[0]));
    IOTRI_OB_EB \y_pad[1]/U0/U1  (.D(\y_pad_RNO[1]_net_1 ), .E(VCC), 
        .DOUT(\y_pad[1]/U0/NET1 ), .EOUT(\y_pad[1]/U0/NET2 ));
    IOPAD_TRI \y_pad[2]/U0/U0  (.D(\y_pad[2]/U0/NET1 ), .E(
        \y_pad[2]/U0/NET2 ), .PAD(y[2]));
    IOTRI_OB_EB \y_pad[0]/U0/U1  (.D(\y_pad_RNO[0]_net_1 ), .E(VCC), 
        .DOUT(\y_pad[0]/U0/NET1 ), .EOUT(\y_pad[0]/U0/NET2 ));
    IOIN_IB \en_pad/U0/U1  (.YIN(\en_pad/U0/NET1 ), .Y(en_c));
    IOIN_IB \b_pad/U0/U1  (.YIN(\b_pad/U0/NET1 ), .Y(b_c));
    IOTRI_OB_EB \y_pad[2]/U0/U1  (.D(un7_y_net_1), .E(VCC), .DOUT(
        \y_pad[2]/U0/NET1 ), .EOUT(\y_pad[2]/U0/NET2 ));
    IOPAD_IN \a_pad/U0/U0  (.PAD(a), .Y(\a_pad/U0/NET1 ));
    OR3A \y_pad_RNO[0]  (.A(en_c), .B(b_c), .C(a_c), .Y(
        \y_pad_RNO[0]_net_1 ));
    IOPAD_TRI \y_pad[3]/U0/U0  (.D(\y_pad[3]/U0/NET1 ), .E(
        \y_pad[3]/U0/NET2 ), .PAD(y[3]));
    IOTRI_OB_EB \y_pad[3]/U0/U1  (.D(\y_pad_RNO[3]_net_1 ), .E(VCC), 
        .DOUT(\y_pad[3]/U0/NET1 ), .EOUT(\y_pad[3]/U0/NET2 ));
    OR3B \y_pad_RNO[1]  (.A(b_c), .B(en_c), .C(a_c), .Y(
        \y_pad_RNO[1]_net_1 ));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
