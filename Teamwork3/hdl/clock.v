module _1s_clock(
    input Rst, Clk, // Reset input and Clock input (1kHz)
    output reg Cout    // 1s clock output (1Hz)
);
    // This is a module that converts specified 1kHz clock input to 1Hz clock output.
    reg [9:0] Count;    // 
    always @(posedge Clk)
        begin
            if (Rst) begin
                // If a reset signal is received, reset the counter and output
                begin
                    Count <= 0;
                    Cout <= 0;
                end
            end else if (Count == 10'b11_1110_0111) begin  // If counter reaches 999
                Count <= 0;
                Cout <= 1;
            end else begin
                Count <= Count + 1;
                Cout <= 0;
            end
        end

endmodule