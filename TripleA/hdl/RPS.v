module Rock_Paper_Scissors (
    input Clk, Rst, // Clock and Reset signals
    input wire [2:0] player1_input, // Player 1 choice: 3-bit input
    input wire [2:0] player2_input, // Player 2 choice: 3-bit input
    input play_with_bot,          // Play with bot flag
    output reg [2:0] winner_output, // Winner output: 3-bit output
    output reg [2:0] player1_choice,    // Use to indicate player 1 choice on traffic light
    output reg [2:0] player2_choice     // Use to indicate player 2 choice on traffic light
);
    // The module that determines the winner of a Rock-Paper-Scissors game
    // Encoding: 3'b001 = Rock, 3'b010 = Scissors, 3'b100 = Paper, which follows Chinese sequence Rock -> Scissors -> Paper
    // Output: 3'b100 = Player 1 wins, 3'b001 = Player 2 wins, 3'b010 = Game draw
    // Use traffic light to indicate winner: 100 -> Red (P1 wins), 001 -> Green (P2 wins), 010 -> Yellow (Draw)
    // Also use the traffic light on left and right to indicate player choices
    // Red -> Rock, Yellow -> Scissors, Green -> Paper

    reg [1:0] bot_input;
    reg [7:0] random_reg;

    parameter ROCK = 3'b001;
    parameter SCISSORS = 3'b010;
    parameter PAPER = 3'b100;
    parameter EMPTY = 3'b000;

    parameter P1_WIN = 3'b100;
    parameter P2_WIN = 3'b001;
    parameter DRAW = 3'b010;
    parameter NO_WINNER = 3'b000;

    parameter ALL = 3'b111;

    parameter RANDOM_SEED = 8'hcc;

    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin  // On reset, initialize the random register
            random_reg <= RANDOM_SEED;
        end else begin  // LSFR pseudo-random generator
            random_reg <= {random_reg[6:0], random_reg[7] ^ random_reg[5] ^ random_reg[4] ^ random_reg[3]}; 
        end
    end


    always @(*) begin
        if (Rst) begin
            winner_output = ALL;
            player1_choice = ALL;
            player2_choice = ALL;
            bot_input = 2'b00;
        end else begin
            player1_choice = player1_input;
            if (!play_with_bot) begin
                player2_choice = player2_input;
            end else begin
                // Generate bot choice randomly
                bot_input = random_reg % 3; // define which choice the bot makes
                case (bot_input)
                    0: player2_choice = ROCK;
                    1: player2_choice = SCISSORS;
                    2: player2_choice = PAPER;
                    default: player2_choice = EMPTY;
                endcase
            end

            if (player1_choice == EMPTY || player2_choice == EMPTY || // Both players have no input
                (player1_choice != ROCK && player1_choice != PAPER && player1_choice != SCISSORS) ||    // Invalid input for player 1
                (player2_choice != ROCK && player2_choice != PAPER && player2_choice != SCISSORS)   // Invalid input for player 2
            ) begin
                // No valid input
                winner_output = NO_WINNER; // No winner
            end else if (player1_choice == player2_choice) begin
                // Draw
                winner_output = DRAW; // Draw
            end else if (
                (player1_choice == ROCK && player2_choice == SCISSORS) ||
                (player1_choice == PAPER && player2_choice == ROCK) ||
                (player1_choice == SCISSORS && player2_choice == PAPER)
            ) begin
                // Player 1 wins
                winner_output = P1_WIN; // Player 1 wins
            end else begin
                // Player 2 wins
                winner_output = P2_WIN; // Player 2 wins
            end
        end
    end


endmodule