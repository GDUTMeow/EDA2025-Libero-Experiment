module dynamic_led(
    output [7:0] Seg,   // Digital BCD output
    output [3:0] Sel,   // Digit select output
    input Clk, Rst
);
    reg [3:0] Sel_reg, Disp_data;    // Digit select register and display data register
    reg [1:0] count;            // Counter for scanning
    wire LT_N, BI_N;          // LT and BI control signals, active low
    wire LE;               // LE control signal, active high

    // Initialize the control part
    assign LT_N = 1'b1;
    assign BI_N = 1'b1;
    assign LE = 1'b0;

    // Status transfer
    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            count = 0;
        end else begin
            count = count + 1'b1;
        end
    end

    // Digit select and display data selection
    always @(count) begin
        case (count[1:0])
            2'b00: Disp_data = 4'b0100;
            2'b01: Disp_data = 4'b0011;
            2'b10: Disp_data = 4'b0011;
            2'b11: Disp_data = 4'b0011;
        endcase
        case (count[1:0])
            2'b00: Sel_reg = 4'b1110;
            2'b01: Sel_reg = 4'b1101;
            2'b10: Sel_reg = 4'b1011;
            2'b11: Sel_reg = 4'b0111;
        endcase
    end

    HC4511 u_hc4511 (
        .A(Disp_data), .Seg(Seg), .LT_N(LT_N), .BI_N(BI_N), .LE(LE)
    );  // BCD to 7-segment decoder

    assign Sel = Sel_reg;

endmodule