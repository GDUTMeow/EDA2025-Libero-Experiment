`timescale 1ns/1ns

module testbench;

    reg Clk, Rst;
    wire [7:0] Seg;
    wire [3:0] Sel;
    dynamic_led u_led(.Clk(Clk), .Rst(Rst), .Seg(Seg), .Sel(Sel));

    parameter DELY=20;
    always #(DELY/2) Clk = ~Clk; // 25MHz clock

    initial begin
        Clk = 0;
        Rst = 0;
        $display("[+] Starting testbench...");
        #(DELY*2) Rst = 1;
        #DELY Rst = 0;
        #(DELY*20) $finish;
    end

endmodule