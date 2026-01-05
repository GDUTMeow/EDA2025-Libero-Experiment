`timescale 1ns/1ns

module testbench;
    reg Clk, Rst, en;
    wire R1, R2, Y1, Y2, G1, G2;
    wire [7:0] Seg;
    wire [3:0] Sel;

    parameter DELY = 1_000_000; // 1ms
    parameter [63:0] SECOND = 1_000_000_000;

    initial Clk = 0;
    always #(DELY/2) Clk = ~Clk; // 1kHz

    top_module u_test (
        .Rst(Rst), .Clk(Clk), .en(en),
        .R1(R1), .R2(R2), .Y1(Y1), .Y2(Y2), .G1(G1), .G2(G2),
        .Seg(Seg), .Sel(Sel)
    );

    initial begin
        $display("[+] Starting testbench...");
        Rst = 1; en = 0;
        # (DELY * 10); // Hold reset for 10ms
        Rst = 0; en = 1;
        
        // Monitor some transitions
        # (SECOND * 5); 
        $display("[*] Time = %t | Seg=%b, Sel=%b", $time, Seg, Sel);
        
        # (SECOND * 60);
        $display("[*] Time = %t | Lights Changed", $time);
        
        # (SECOND * 100);
        $display("[+] Testbench completed.");
        $stop;
    end
endmodule