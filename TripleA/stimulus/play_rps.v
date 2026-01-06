`timescale 1ns/1ns

module play_rps;

    reg Clk, Rst;
    reg [2:0] player1_input;
    reg [2:0] player2_input;
    reg play_with_bot;
    wire [2:0] winner_output;
    wire [2:0] player1_choice;
    wire [2:0] player2_choice;

    integer i;

    Rock_Paper_Scissors u_rps (
        .Clk(Clk),
        .Rst(Rst),
        .player1_input(player1_input),
        .player2_input(player2_input),
        .play_with_bot(play_with_bot),
        .winner_output(winner_output),
        .player1_choice(player1_choice),
        .player2_choice(player2_choice)
    );

    initial Clk = 0;
    always #5 Clk = ~Clk; // 10Hz clock

    initial begin
        $display("[+] Starting Rock-Paper-Scissors Simulation...");
        // Reset the system
        $display("[*] Applying Reset...");
        Rst = 1;
        #10;
        $display("[*] Player 1 input: %b, Player 1 choice: %b, Player 2 input: %b, Player 2 choice: %b, Winner: %b", player1_input, player1_choice, player2_input, player2_choice, winner_output);
        Rst = 0;
        $display("[*] Releasing Reset...");
        #10;
        // Two player test
        play_with_bot = 0;
        // case 1 for player 1 wins
        player1_input = 3'b001; // Rock
        player2_input = 3'b100; // Scissors
        #5 $display("[*] Player 1 input: %b, Player 1 choice: %b, Player 2 input: %b, Player 2 choice: %b, Winner: %b", player1_input, player1_choice, player2_input, player2_choice, winner_output);
        player1_input = 3'b010; // Paper
        player2_input = 3'b001; // Rock
        #5 $display("[*] Player 1 input: %b, Player 1 choice: %b, Player 2 input: %b, Player 2 choice: %b, Winner: %b", player1_input, player1_choice, player2_input, player2_choice, winner_output);
        player1_input = 3'b100; // Scissors
        player2_input = 3'b010; // Paper
        #5 $display("[*] Player 1 input: %b, Player 1 choice: %b, Player 2 input: %b, Player 2 choice: %b, Winner: %b", player1_input, player1_choice, player2_input, player2_choice, winner_output);
        // case 2 for player 2 wins
        player1_input = 3'b001; // Rock
        player2_input = 3'b010; // Paper
        #5 $display("[*] Player 1 input: %b, Player 1 choice: %b, Player 2 input: %b, Player 2 choice: %b, Winner: %b", player1_input, player1_choice, player2_input, player2_choice, winner_output);
        player1_input = 3'b010; // Paper
        player2_input = 3'b100; // Scissors
        #5 $display("[*] Player 1 input: %b, Player 1 choice: %b, Player 2 input: %b, Player 2 choice: %b, Winner: %b", player1_input, player1_choice, player2_input, player2_choice, winner_output);
        player1_input = 3'b100; // Scissors
        player2_input = 3'b001; // Rock
        #5 $display("[*] Player 1 input: %b, Player 1 choice: %b, Player 2 input: %b, Player 2 choice: %b, Winner: %b", player1_input, player1_choice, player2_input, player2_choice, winner_output);
        // case 3 for game draw
        player1_input = 3'b001; // Rock
        player2_input = 3'b001; // Rock
        #5 $display("[*] Player 1 input: %b, Player 1 choice: %b, Player 2 input: %b, Player 2 choice: %b, Winner: %b", player1_input, player1_choice, player2_input, player2_choice, winner_output);
        player1_input = 3'b010; // Paper
        player2_input = 3'b010; // Paper
        #5 $display("[*] Player 1 input: %b, Player 1 choice: %b, Player 2 input: %b, Player 2 choice: %b, Winner: %b", player1_input, player1_choice, player2_input, player2_choice, winner_output);
        player1_input = 3'b100; // Scissors
        player2_input = 3'b100; // Scissors
        #5 $display("[*] Player 1 input: %b, Player 1 choice: %b, Player 2 input: %b, Player 2 choice: %b, Winner: %b", player1_input, player1_choice, player2_input, player2_choice, winner_output);

        // Play with bot test, for 10 rounds
        // Player 1's choice rotate in Rock, Paper, Scissors
        play_with_bot = 1;
        for (i = 0; i < 10; i = i + 1) begin
            case (i % 3)
                0: player1_input = 3'b001; // Rock
                1: player1_input = 3'b010; // Paper
                2: player1_input = 3'b100; // Scissors
            endcase
            #10; // Wait for bot to generate choice
            $display("[*] Player 1 input: %b, Player 1 choice: %b, Bot: %b, Winner: %b", player1_input, player1_choice, player2_choice, winner_output);
        end
        $display("[+] Rock-Paper-Scissors Simulation completed.");
    end

endmodule