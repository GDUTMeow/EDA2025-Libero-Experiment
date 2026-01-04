module two_lights(
    input Clk, Rst, en,    // Clock input, Reset input and Enable input
    input tick_1s,          // 1 second tick input, which is a must in order to avoid race
    output reg R1, R2, Y1, Y2, G1, G2   // Traffic light outputs
);
    // R1 -> Light 1 Red, R2 -> Light 2 Red
    // Y1 -> Light 1 Yellow, Y2 -> Light 2 Yellow
    // G1 -> Light 1 Green, G2 -> Light 2 Green
    // Loop: R1G2 --55s--> R1Y2 --5s--> G1R2 --55s--> Y1R2 --5s--> R1G2
    // parameter define as R1R2Y1Y2G1G2 = 6'b<value>
    // Light 1 -> NS, Light 2 -> EW
    parameter R1R2 = 6'b110000;
    parameter R1G2 = 6'b100001;
    parameter R1Y2 = 6'b100100;
    parameter G1R2 = 6'b010010;
    parameter Y1R2 = 6'b011000;
    reg [5:0] state = R1R2;    // Current State
    reg [5:0] next_state = R1R2; // Next State

    reg [7:0] counter;  // 8-bit counter for timer

    initial state = R1R2;

    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            next_state = R1R2; // Reset to R1R2 state
            counter <= 0;
        end else if (!en) begin
            next_state = R1R2;
            counter <= 0;
        end else if (tick_1s) begin
            case (state)
                R1R2: begin
                    next_state = R1G2;  // Move to Red-Green state
                    counter <= 0;
                end
                R1G2: begin
                    if (counter == 8'd54) begin // Light 2 Green for 55s
                        counter <= 0;
                        next_state = R1Y2;
                    end else begin
                        counter <= counter + 1;
                    end
                end
                R1Y2: begin
                    if (counter == 8'd4) begin // Light 2 Yellow for 5s
                        counter <= 0;
                        next_state = G1R2;
                    end else begin
                        counter <= counter + 1;
                    end
                end
                G1R2: begin
                    if (counter == 8'd54) begin // Light 1 Green for 55s
                        counter <= 0;
                        next_state = Y1R2;
                    end else begin
                        counter <= counter + 1;
                    end
                end
                Y1R2: begin
                    if (counter == 8'd4) begin // Light 1 Yellow for 5s
                        counter <= 0;
                        next_state = R1G2;
                    end else begin
                        counter <= counter + 1;
                    end
                end
                default: next_state = R1R2; // Default to R1R2, which means invalid state
            endcase
        end
    end

    // State register
    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            state <= R1R2; // Reset to R1R2 state
        end else begin
            state <= next_state; // Update state
        end
    end

    // Output decoding
    always @(state) begin
        {R1, R2, Y1, Y2, G1, G2} = state;
    end
endmodule