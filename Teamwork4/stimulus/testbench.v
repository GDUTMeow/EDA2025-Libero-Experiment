`timescale 100ms/1ns

module testbench;

    reg Clk, Rst;
    reg [1:0] light_mode;
    wire [25:0] led;

    running_light u_rl (
        .Clk(Clk),
        .Rst(Rst),
        .light_mode(light_mode),
        .led(led)
    );

    always #5 Clk = ~Clk; // 10Hz clock

    initial begin
        $display("[+] Starting Testbench...");
        Clk = 0;
        Rst = 1;
        #200; // Hold reset for 200ms
        Rst = 0;
        $display("[*] Releasing Reset, starting in Mode 0");
        light_mode = 2'b00; // Mode 0
        #1000; // Run for 1s
        $display("[*] Rst = %b, Mode = %b, LED = %b", Rst, light_mode, led);
        $display("[*] Switching to Mode 1");
        light_mode = 2'b01; // Mode 1
        #2000; // Run for 2s
        $display("[*] Rst = %b, Mode = %b, LED = %b", Rst, light_mode, led);
        $display("[*] Switching to Mode 2");
        light_mode = 2'b10; // Mode 2
        #2000; // Run for 2s
        $display("[*] Rst = %b, Mode = %b, LED = %b", Rst, light_mode, led);
        $display("[*] Switching to Mode 3");
        light_mode = 2'b11; // Mode 3
        #2000; // Run for 2s
        $display("[*] Rst = %b, Mode = %b, LED = %b", Rst, light_mode, led);
        $display("[+] Testbench completed.");
    end

endmodule