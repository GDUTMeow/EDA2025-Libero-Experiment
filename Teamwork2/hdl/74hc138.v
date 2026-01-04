module _74hc138 (
    input a0, a1, a2,           // 3 lines input
    input e1, e2,               // 2 enable inputs, low active
    input e3,                   // 1 enable input, high active
    output reg y0, y1, y2, y3, y4, y5, y6, y7   // 8 lines output, low active
);

    always @(a0, a1, a2, e1, e2, e3) begin
        // Set default output to H
        {y7, y6, y5, y4, y3, y2, y1, y0} = 8'b11111111;

        // Check if Y should be enabled
        if (e1 || e2 || !e3) begin // Not enabled
            // e1 = 1 or e2 = 1 or e3 = 0 -> all high
            {y7, y6, y5, y4, y3, y2, y1, y0} = 8'b11111111;
        end else begin
            // e1 = 0, e2 = 0, e3 = 1 -> enabled
            case ({a2, a1, a0})
                3'b000: {y7, y6, y5, y4, y3, y2, y1, y0} = 8'b11111110; // Y0 = L
                3'b001: {y7, y6, y5, y4, y3, y2, y1, y0} = 8'b11111101; // Y1 = L
                3'b010: {y7, y6, y5, y4, y3, y2, y1, y0} = 8'b11111011; // Y2 = L
                3'b011: {y7, y6, y5, y4, y3, y2, y1, y0} = 8'b11110111; // Y3 = L
                3'b100: {y7, y6, y5, y4, y3, y2, y1, y0} = 8'b11101111; // Y4 = L
                3'b101: {y7, y6, y5, y4, y3, y2, y1, y0} = 8'b11011111; // Y5 = L
                3'b110: {y7, y6, y5, y4, y3, y2, y1, y0} = 8'b10111111; // Y6 = L
                3'b111: {y7, y6, y5, y4, y3, y2, y1, y0} = 8'b01111111; // Y7 = L
                default: {y7, y6, y5, y4, y3, y2, y1, y0} = 8'b11111111; // Default to all high
            endcase
        end
    end
endmodule
