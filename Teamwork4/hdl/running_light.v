module running_light (
    input Clk,              // Clock input, fixed to 10Hz
    input Rst,              // Reset input, active high
    input [1:0] light_mode, // 2-bit switch to select display pattern
    output reg [25:0] led        // 26 LED outputs
);

    // Timing parameters based on 10Hz clock
    parameter M1_CLK_NEEDED = 4'd2; // Div by 2, Action every 2 cycles
    parameter M2_CLK_NEEDED = 4'd8; // Div by 8, Action every 8 cycles
    parameter M3_CLK_NEEDED = 4'd4; // Div by 4, Action every 4 cycles
    parameter M4_CLK_NEEDED = 4'd1; // Div by 1, Action every cycle

    reg [3:0] clock_counter;  // Counter for frequency division
    reg [3:0] fill_step;      // Step counter for Mode 2 (0-15)
    reg [2:0] sym_step;       // Step counter for Mode 3 (0-7)
    reg [1:0] mode_record;    // To detect when the user switches modes
    reg [7:0] lfsr_reg;       // Register for hardware random number generation
    reg m1_toggle;            // For Mode 1 pattern switching

    // LFSR for random number generation
    always @(posedge Clk or posedge Rst) begin
        if (Rst) 
            lfsr_reg <= 8'hcc; // Initial non-zero seed
        else 
            // Standard 8-bit LFSR polynomial
            lfsr_reg <= {lfsr_reg[6:0], lfsr_reg[7] ^ lfsr_reg[5] ^ lfsr_reg[4] ^ lfsr_reg[3]};
    end

    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            led <= 26'b0;   // Turn off all LEDs on reset
            fill_step <= 0; // Reset fill step
            sym_step <= 0;  // Reset symmetrical step
            mode_record <= 2'b00;   // Default mode
            clock_counter <= 4'd1;  // Start counter at 1
            m1_toggle <= 0; // Reset toggle for Mode 1
        end else begin
            // If mode switch changes, reset everything
            if (light_mode != mode_record) begin
                led <= 26'b0;
                fill_step <= 0;
                sym_step <= 0;
                mode_record <= light_mode;
                clock_counter <= 4'd1;
            end else begin
                case (light_mode)
                    // Odd/Even alternate
                    2'b00: begin
                        if (clock_counter >= M1_CLK_NEEDED) begin
                            led[25:8] <= 18'b0;
                            m1_toggle <= ~m1_toggle;
                            led[7:0]  <= (m1_toggle) ? 8'b10101010 : 8'b01010101;
                            clock_counter <= 1;
                        end else begin
                            clock_counter <= clock_counter + 1;
                        end
                    end

                    // Progressive fill and drain
                    2'b01: begin
                        if (clock_counter >= M2_CLK_NEEDED) begin
                            led[25:8] <= 18'b0;
                            if (fill_step < 8)
                                led[fill_step] <= 1'b1;     // Fill
                            else
                                led[fill_step - 8] <= 1'b0; // Drain
                            
                            fill_step <= fill_step + 1;     // Loop 0-15
                            clock_counter <= 1;
                        end else begin
                            clock_counter <= clock_counter + 1;
                        end
                    end

                    // Symmetrical flow
                    2'b10: begin
                        if (clock_counter >= M3_CLK_NEEDED) begin
                            led[25:8] <= 18'b0;
                            if (sym_step < 4) begin
                                led[sym_step]     <= 1'b1; // Turn on from edges
                                led[7 - sym_step] <= 1'b1;
                            end else begin
                                led[sym_step - 4]     <= 1'b0; // Turn off from edges
                                led[7 - (sym_step - 4)] <= 1'b0;
                            end
                            sym_step <= sym_step + 1; // Loop 0-7
                            clock_counter <= 1;  // Reset counter
                        end else begin
                            clock_counter <= clock_counter + 1;
                        end
                    end

                    // Random bouncing
                    2'b11: begin
                        // Using LFSR output to pick a random index 0-25
                        if (lfsr_reg[4:0] < 26)
                            led <= (26'b1 << lfsr_reg[4:0]);
                        else
                            led <= 26'b1; // Default
                        clock_counter <= 1;  // Reset counter
                    end

                    default: led <= 26'b0;
                endcase
            end
        end
    end

endmodule