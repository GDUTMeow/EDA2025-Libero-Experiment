`timescale 1ns/1ns

module testbench;

    reg Clk, Rst, en;
    wire R1, R2, Y1, Y2, G1, G2;
    wire [7:0] Seg;
    wire [3:0] Sel;

    parameter DELY=1_000_000;   // 1ms delay
    parameter [63:0] SECOND = 1_000_000_000; // 1 second in ns
    initial Clk = 0;
    always #(DELY/2) Clk = ~Clk; // 1kHz clock

    top_module u_test (
        .Rst(Rst),
        .Clk(Clk),
        .en(en),
        .R1(R1),
        .R2(R2),
        .Y1(Y1),
        .Y2(Y2),
        .G1(G1),
        .G2(G2),
        .Seg(Seg),
        .Sel(Sel)
    );

    initial begin
        $display("[+] Starting testbench...");
        // Initialize all signals
        Rst = 0;
        en = 0;
        // Test sequence
        repeat(54) #SECOND;
        // @(negedge Clk); // Use negative edge to reset signal to prevent race
        Rst = 1; // Assert reset
        // except R1 = 1, R2 = 1
        repeat(1) #SECOND;
        $display("[*] Time = %t: R1=%b, Y1=%b, G1=%b | R2=%b, Y2=%b, G2=%b | Seg=%b, Sel=%b | Rst = %b, en = %b", $time, R1, Y1, G1, R2, Y2, G2, Seg, Sel, Rst, en);
        repeat(10) #(SECOND); 
        // @(negedge Clk); // Use negative edge to reset signal to prevent race
        Rst = 0; en = 1; // Deassert reset and enable
        // except R1 = 1, R2 = 0, G2 = 1
        repeat(1) #SECOND;
        $display("[*] Time = %t: R1=%b, Y1=%b, G1=%b | R2=%b, Y2=%b, G2=%b | Seg=%b, Sel=%b | Rst = %b, en = %b", $time, R1, Y1, G1, R2, Y2, G2, Seg, Sel, Rst, en);
        repeat(54) #SECOND;
        // 55 seconds passed, expect R1=1, Y2=1, G2 = 0
        repeat(1) #SECOND;
        $display("[*] Time = %t: R1=%b, Y1=%b, G1=%b | R2=%b, Y2=%b, G2=%b | Seg=%b, Sel=%b | Rst = %b, en = %b", $time, R1, Y1, G1, R2, Y2, G2, Seg, Sel, Rst, en);
        repeat(4) #SECOND;
        // 5 seconds passed, expect G1=1, R2=1
        repeat(1) #SECOND;
        $display("[*] Time = %t: R1=%b, Y1=%b, G1=%b | R2=%b, Y2=%b, G2=%b | Seg=%b, Sel=%b | Rst = %b, en = %b", $time, R1, Y1, G1, R2, Y2, G2, Seg, Sel, Rst, en);
        repeat(54) #SECOND;
        // 55 seconds passed, expect Y1=1, R2=1
        repeat(1) #SECOND;
        $display("[*] Time = %t: R1=%b, Y1=%b, G1=%b | R2=%b, Y2=%b, G2=%b | Seg=%b, Sel=%b | Rst = %b, en = %b", $time, R1, Y1, G1, R2, Y2, G2, Seg, Sel, Rst, en);
        repeat(4) #SECOND;
        // 5 seconds passed, expect R1=1, R2=0, G2=1
        repeat(1) #SECOND;
        $display("[*] Time = %t: R1=%b, Y1=%b, G1=%b | R2=%b, Y2=%b, G2=%b | Seg=%b, Sel=%b | Rst = %b, en = %b", $time, R1, Y1, G1, R2, Y2, G2, Seg, Sel, Rst, en);
        repeat(10) #SECOND; en = 0; // Disable the traffic light
        // expect R1=1, R2=1
        repeat(1) #SECOND;
        $display("[*] Time = %t: R1=%b, Y1=%b, G1=%b | R2=%b, Y2=%b, G2=%b | Seg=%b, Sel=%b | Rst = %b, en = %b", $time, R1, Y1, G1, R2, Y2, G2, Seg, Sel, Rst, en);
        $display("[+] Testbench completed.");
    end

endmodule