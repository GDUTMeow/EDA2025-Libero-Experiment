module timer(
    input Clk, Rst, en,
    input tick_1s,
    output [7:0] Seg,   // Digital BCD output
    output [3:0] Sel    // Digit select output
);
    // This is a module that shows that rest of time to change the traffic light
    reg [3:0] Sel_reg; // digit select register
    reg [3:0] Display_data; // display data register
    reg [1:0] Scanning_count; // scanning counter

    wire LT_N, BI_N;          // LT and BI control signals, active low
    wire LE;               // LE control signal, active high

    // Initialize the control part
    assign LT_N = 1'b1;
    assign BI_N = 1'b1;
    assign LE = 1'b0;

    reg [5:0] light1_count; // the counter for light 1, 60 seconds max
    reg [5:0] light2_count; // the counter for light 2, 60 seconds max
    reg [2:0] light1_state; // the state for light 1
    reg [2:0] light2_state; // the state for light 2

    parameter RED_LIGHT = 6'd60;  // 60 seconds for red light
    parameter YELLOW_LIGHT = 6'd5;  // 5 seconds for yellow light
    parameter GREEN_LIGHT = 6'd55;  // 55 seconds for green light

    parameter RED = 3'b100;
    parameter YELLOW = 3'b010;
    parameter GREEN = 3'b001;

    reg [7:0] D_high; // high 2 digits on BCD
    reg [7:0] D_low;  // low 2 digits on BCD

    reg [3:0] D_High_H;
    reg [3:0] D_High_L;
    reg [3:0] D_Low_H;
    reg [3:0] D_Low_L;

    initial begin
        D_High_H = 4'b0110; // '6'
        D_High_L = 4'b0000; // '0'
        D_Low_H = 4'b0101;  // '5'
        D_Low_L = 4'b0101;  // '5'
    end

    // Status transfer
    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            light1_count <= 6'd60; // Reset to 60 seconds
            light2_count <= 6'd55; // Reset to 55 seconds
            light1_state <= RED;
            light2_state <= GREEN;
            Scanning_count <= 2'b00;
        end else begin
            if (en && tick_1s) begin
                if (light1_count == 6'd1) begin
                    // Change state for light 1
                    case (light1_state)
                        RED: begin
                            light1_state <= GREEN;
                            light1_count <= GREEN_LIGHT;
                        end
                        GREEN: begin
                            light1_state <= YELLOW;
                            light1_count <= YELLOW_LIGHT;
                        end
                        YELLOW: begin
                            light1_state <= RED;
                            light1_count <= RED_LIGHT;
                        end
                    endcase
                end else begin
                    light1_count <= light1_count - 1'b1;
                end
            end
            if (en && tick_1s) begin
                if (light2_count == 6'd1) begin
                    // Change state for light 2
                    case (light2_state)
                        RED: begin
                            light2_state <= GREEN;
                            light2_count <= GREEN_LIGHT;
                        end
                        GREEN: begin
                            light2_state <= YELLOW;
                            light2_count <= YELLOW_LIGHT;
                        end
                        YELLOW: begin
                            light2_state <= RED;
                            light2_count <= RED_LIGHT;
                        end
                    endcase
                end else begin
                    light2_count <= light2_count - 1'b1;
                end
            end
            Scanning_count <= Scanning_count + 1'b1;
        end
    end

    // BCD output assignment
    always @(*) begin
        case (Scanning_count)
            2'b00: begin 
                Display_data = light1_count / 10;   // tens digit of light 1
                Sel_reg = 4'b1011;  // activate first digit
            end
            2'b01: begin 
                Display_data = light1_count % 10;   // units digit of light 1
                Sel_reg = 4'b0111;  // activate second digit
            end
            2'b10: begin 
                Display_data = light2_count / 10;   // tens digit of light 2
                Sel_reg = 4'b1110;  // activate third digit
            end
            2'b11: begin 
                Display_data = light2_count % 10;   // units digit of light 2
                Sel_reg = 4'b1101;  // activate fourth digit
            end
        endcase
    end

    HC4511 u_4511(
        .A(Display_data), .Seg(Seg), .LT_N(LT_N), .BI_N(BI_N), .LE(LE)
    );

    assign Sel = Sel_reg;

endmodule