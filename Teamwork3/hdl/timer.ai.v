module timer(
    input Clk, Rst, en,
    output [7:0] Seg,   // Digital BCD output
    output [3:0] Sel    // Digit select output
);
    reg [3:0] Sel_reg; 
    reg [3:0] Display_data; 
    reg [1:0] Scanning_count; 
    reg [9:0] clk_divider; // Internal counter to divide 1kHz to 1Hz

    // Control signals for HC4511
    wire LT_N = 1'b1;
    wire BI_N = 1'b1;
    wire LE = 1'b0;

    reg [5:0] light1_count; 
    reg [5:0] light2_count; 
    reg [2:0] light1_state; 
    reg [2:0] light2_state; 

    parameter RED_LIGHT = 6'd60;
    parameter YELLOW_LIGHT = 6'd5;
    parameter GREEN_LIGHT = 6'd55;

    parameter RED = 3'b100;
    parameter YELLOW = 3'b010;
    parameter GREEN = 3'b001;

    // Main sequential logic
    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            light1_count <= 6'd60;
            light2_count <= 6'd55;
            light1_state <= RED;
            light2_state <= GREEN;
            Scanning_count <= 2'b00;
            clk_divider <= 10'd0;
        end else begin
            // 1. Digit Scanning logic (runs at 1kHz)
            Scanning_count <= Scanning_count + 1'b1;

            // 2. 1-Second Tick Generation and Countdown logic
            if (en) begin
                if (clk_divider == 10'd999) begin
                    clk_divider <= 10'd0; // Reset divider every 1 second
                    
                    // Countdown Light 1
                    if (light1_count == 6'd1) begin
                        case (light1_state)
                            RED:    begin light1_state <= GREEN;  light1_count <= GREEN_LIGHT; end
                            GREEN:  begin light1_state <= YELLOW; light1_count <= YELLOW_LIGHT; end
                            YELLOW: begin light1_state <= RED;    light1_count <= RED_LIGHT; end
                        endcase
                    end else begin
                        light1_count <= light1_count - 1'b1;
                    end

                    // Countdown Light 2
                    if (light2_count == 6'd1) begin
                        case (light2_state)
                            RED:    begin light2_state <= GREEN;  light2_count <= GREEN_LIGHT; end
                            GREEN:  begin light2_state <= YELLOW; light2_count <= YELLOW_LIGHT; end
                            YELLOW: begin light2_state <= RED;    light2_count <= RED_LIGHT; end
                        endcase
                    end else begin
                        light2_count <= light2_count - 1'b1;
                    end
                end else begin
                    clk_divider <= clk_divider + 1'b1;
                end
            end
        end
    end

    // BCD Scanning display logic
    always @(*) begin
        case (Scanning_count)
            2'b00: begin 
                Display_data = light1_count / 10;
                Sel_reg = 4'b1011; 
            end
            2'b01: begin 
                Display_data = light1_count % 10;
                Sel_reg = 4'b0111; 
            end
            2'b10: begin 
                Display_data = light2_count / 10;
                Sel_reg = 4'b1110; 
            end
            2'b11: begin 
                Display_data = light2_count % 10;
                Sel_reg = 4'b1101; 
            end
        endcase
    end

    HC4511 u_4511(.A(Display_data), .Seg(Seg), .LT_N(LT_N), .BI_N(BI_N), .LE(LE));
    assign Sel = Sel_reg;

endmodule