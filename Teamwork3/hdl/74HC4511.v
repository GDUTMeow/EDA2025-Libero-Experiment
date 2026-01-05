module HC4511 (A, Seg, LT_N, BI_N, LE);

    input LT_N, BI_N, LE;   // Control signals
    input [3:0] A;  // BCD input
    output [7:0] Seg;   // 7-segment output
    
    reg [7:0] SM_8S;    // 7-segment register

    assign Seg = SM_8S;

    always @(A or LT_N or BI_N or LE)
    begin
        if (!LT_N)
            SM_8S = 8'b11111111;    // all segments lit for test
        else if (!BI_N)
            SM_8S = 8'b00000000;    // all segments off
        else if (LE)
            SM_8S = SM_8S;  // latch enabled, hold previous value
        else
            case (A)
                4'd0 : SM_8S = 8'b00111111; // Segment display 0
                4'd1 : SM_8S = 8'b00000110; // Segment display 1
                4'd2 : SM_8S = 8'b01011011; // Segment display 2
                4'd3 : SM_8S = 8'b01001111; // Segment display 3
                4'd4 : SM_8S = 8'b01100110; // Segment display 4
                4'd5 : SM_8S = 8'b01101101; // Segment display 5
                4'd6 : SM_8S = 8'b01111101; // Segment display 6
                4'd7 : SM_8S = 8'b00000111; // Segment display 7
                4'd8 : SM_8S = 8'b01111111; // Segment display 8
                4'd9 : SM_8S = 8'b01101111; // Segment display 9
                4'd10: SM_8S = 8'b01110111; // Segment display A
                4'd11: SM_8S = 8'b01111100; // Segment display B
                4'd12: SM_8S = 8'b00111001; // Segment display C
                4'd13: SM_8S = 8'b01011110; // Segment display D
                4'd14: SM_8S = 8'b01111001; // Segment display E
                4'd15: SM_8S = 8'b01110001; // Segment display F
                default: SM_8S = 8'b00000000;
            endcase
    end

endmodule
