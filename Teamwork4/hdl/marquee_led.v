///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: marquee_led.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::ProASIC3> <Die::A3P060> <Package::100 VQFP>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module marquee_led (
    input wire clk,           // Clock  (Pin 16)
    input wire rst_n,         // Reset (Low, Pin 13)
    input wire [1:0] mode_sw, // Mode Switches [U7-Key1, U7-Key2]
    output reg [25:0] led     // 26 LED Outputs
);


    reg [31:0] timer_cnt;
    wire tick_mode1, tick_mode2, tick_mode3, tick_mode4;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            timer_cnt <= 0;
        else
            timer_cnt <= timer_cnt + 1;
    end
    assign tick_mode1 = (timer_cnt[21:0] == 0); 
    assign tick_mode3 = (timer_cnt[22:0] == 0); 
    assign tick_mode2 = (timer_cnt[23:0] == 0); 
    assign tick_mode4 = (timer_cnt[20:0] == 0); 
    
    // logic_mode
    reg [3:0] state_m2; // Mode 2 (0-15)
    reg [2:0] state_m3; // Mode 3 (0-7)
    reg [4:0] state_m4; // Mode 4 (0-25)
    reg m4_dir;         

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            led <= 26'b0;
            state_m2 <= 0;
            state_m3 <= 0;
            state_m4 <= 0;
            m4_dir <= 0;
        end else begin
            if (mode_sw != 2'b11) led[25:8] <= 18'b0;

            case (mode_sw)
                2'b00: begin
                    if (tick_mode1) begin
                        if (timer_cnt[22]) 
                            led[7:0] <= 8'b10101010; // ou led_on (2,4,6,8)
                        else 
                            led[7:0] <= 8'b01010101; // ji led_on (1,3,5,7)
                    end
                end

                // Mode 2 (U7=01)
                2'b01: begin
                    if (tick_mode2) begin
                        if (state_m2 < 8) begin
                            // on one by one
                            led[state_m2] <= 1'b1; 
                        end else begin
                            // off one by one
                            led[state_m2 - 8] <= 1'b0; 
                        end
                        
                        // state 0-15
                        state_m2 <= state_m2 + 1;
                    end
                end

                // Mode 3 (U7=10)
                2'b10: begin
                    if (tick_mode3) begin
                        if (state_m3 < 4) begin
                            // on
                            led[state_m3] <= 1'b1;      // Left side
                            led[7 - state_m3] <= 1'b1;  // Right side
                        end else begin
                            // off
                            led[state_m3 - 4] <= 1'b0;
                            led[7 - (state_m3 - 4)] <= 1'b0;
                        end
                        
                        state_m3 <= state_m3 + 1;
                    end
                end

                // Mode 4 (U7=11)
                2'b11: begin
                    if (tick_mode4) begin
                        led <= (26'b1 << state_m4);
                        
                        if (m4_dir == 0) begin // left
                            if (state_m4 == 25) m4_dir <= 1;
                            else state_m4 <= state_m4 + 1;
                        end else begin // right
                            if (state_m4 == 0) m4_dir <= 0;
                            else state_m4 <= state_m4 - 1;
                        end
                    end
                end
            endcase
        end
    end

endmodule