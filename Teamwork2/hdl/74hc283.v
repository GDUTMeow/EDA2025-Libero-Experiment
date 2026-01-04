module _74hc283(
    input a0, a1, a2, a3,    // 4 bits input A, high active
    input b0, b1, b2, b3,    // 4 bits input B, high active
    input cin,               // carry input
    output reg s0, s1, s2, s3, // 4 bits sum output S
    output reg cout          // carry output
);

    always @(a0, a1, a2, a3,
        b0, b1, b2, b3, cin
    ) begin
        // Calculate the result
        s0 = a0 ^ b0 ^ cin;
        s1 = a1 ^ b1 ^ s0;
        s2 = a2 ^ b2 ^ s1;
        s3 = a3 ^ b3 ^ s2;
        cout = (a3 & b3) | (s2 & (a3 ^ b3)) | (s1 & (a2 ^ b2) & (a3 ^ b3)) | (s0 & (a1 ^ b1) & (a2 ^ b2) & (a3 ^ b3));

        // More simple way to calculate
        // {s0, s1, s2, s3} = {a0, a1, a2, a3} + {b0, b1, b2, b3} + cin;
        // cout = ({a0, a1, a2, a3} + {b0, b1, b2, b3} + cin) > 4'b1111;
    end
endmodule