`timescale 1ns/1ns

// Make sure all modules have been compiled
`include "../hdl/74hc04.v"
`include "../hdl/74hc86.v"
`include "74hc04_testbench.v"
`include "74hc86_testbench.v"

module testall_bench;
    // Instantiate all testbenches
    test_74hc04 t_04();
    test_74hc86 t_86();
    
    reg start_signal = 0;   // Without this, the simulation will not run.
    
    initial begin
        $display("[+] Starting all testbenches...");
        #100;   // Wait for all the test passed
        $display("[*] Done");
        // $finish;
    end
endmodule