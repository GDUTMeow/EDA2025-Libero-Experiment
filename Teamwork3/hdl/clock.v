module _1s_clock(
    input Rst, Clk, // Reset input and Clock input (1kHz)
    output reg Cout    // 1s clock output (1Hz)
);
    // This is a module that converts specified 1kHz clock input to 1Hz clock output.
    reg [9:0] Count;    // 
    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            Count <= 10'd0;
            Cout <= 1'b0;
        end else if (Count == 10'd999) begin  // 1000 cycles at 1kHz = 1 second
            Count <= 10'd0;
            Cout <= 1'b1; // one-cycle tick
        end else begin
            Count <= Count + 10'd1;
            Cout <= 1'b0;
        end
    end

endmodule