module two_lights(
    input Clk, Rst, en,
    output reg R1, R2, Y1, Y2, G1, G2
);
    parameter R1R2 = 6'b110000;
    parameter R1G2 = 6'b100001;
    parameter R1Y2 = 6'b100100;
    parameter G1R2 = 6'b010010;
    parameter Y1R2 = 6'b011000;

    reg [5:0] state;
    reg [7:0] sec_counter;
    reg [9:0] clk_divider;

    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            state <= R1R2;
            sec_counter <= 8'd0;
            clk_divider <= 10'd0;
        end else if (!en) begin
            state <= R1R2;
            sec_counter <= 8'd0;
            clk_divider <= 10'd0;
        end else begin
            // Increment divider
            if (clk_divider == 10'd999) begin
                clk_divider <= 10'd0;
                
                // State Machine Transition (Happens once per second)
                case (state)
                    R1R2: begin
                        state <= R1G2;
                        sec_counter <= 8'd0;
                    end
                    R1G2: begin
                        if (sec_counter == 8'd54) begin
                            state <= R1Y2;
                            sec_counter <= 8'd0;
                        end else sec_counter <= sec_counter + 1'b1;
                    end
                    R1Y2: begin
                        if (sec_counter == 8'd4) begin
                            state <= G1R2;
                            sec_counter <= 8'd0;
                        end else sec_counter <= sec_counter + 1'b1;
                    end
                    G1R2: begin
                        if (sec_counter == 8'd54) begin
                            state <= Y1R2;
                            sec_counter <= 8'd0;
                        end else sec_counter <= sec_counter + 1'b1;
                    end
                    Y1R2: begin
                        if (sec_counter == 8'd4) begin
                            state <= R1G2;
                            sec_counter <= 8'd0;
                        end else sec_counter <= sec_counter + 1'b1;
                    end
                    default: state <= R1R2;
                endcase
            end else begin
                clk_divider <= clk_divider + 1'b1;
            end
        end
    end

    // Output decoding
    always @(*) begin
        {R1, R2, Y1, Y2, G1, G2} = state;
    end
endmodule