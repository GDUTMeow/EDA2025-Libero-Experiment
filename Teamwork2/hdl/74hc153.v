module _74hc153 (
    input s0, s1,               // 2 lines input, choose signal source, high active
    input e1, e2,               // 2 channel enable input, low active, e1 -> a channel, e2 -> b channel
    input a0, a1, a2, a3,       // 4 lines input for channel a, high active
    input b0, b1, b2, b3,       // 4 lines input for channel b, high active
    output reg y1, y2           // 2 lines output for channel a & b, high active
);
    always @(s0, s1, e1, e2, a0, a1, a2, a3, b0, b1, b2, b3) begin
        // Initialize output to low
        y1 = 0;
        y2 = 0;
        if (e1 && e2) begin
            // no channel active
            y1 = 0;
            y2 = 0;
        end 
        if (e1 == 0 || (!e1 && !e2)) begin  // unexpected case that both channel are active, give priority to channel a
            // find which input should we use for channel a
            case ({s1, s0})
                2'b00: y1 = a0;
                2'b01: y1 = a1;
                2'b10: y1 = a2;
                2'b11: y1 = a3;
                default: y1 = 0;
            endcase
        end 
        if (e2 == 0) begin
            // find which input should we use for channel b
            case ({s1, s0})
                2'b00: y2 = b0;
                2'b01: y2 = b1;
                2'b10: y2 = b2;
                2'b11: y2 = b3;
                default: y2 = 0;
            endcase
        end
    end

endmodule