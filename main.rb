# frozen_string_literal: true

require_relative 'lib/mastermind/setup/setup'

GameSetup.start

# Pseudocode for Mastermind program
#
# 1. Configure the game settings such as # of colors, # of holes, and modes (PvP, PvCOM, or COMvCOM)
# 2. The player(s) must choose between their roles of being the codemaker or the codebreaker
# 3. The codebreaker must guess pattern of colored objects in a row given by the codemaker.
# 4. The codemaker must check the patterns of colored objects inserted in a row.
# 4. Answer yourself this question: Has the game ended?
#     a. If so, go to Step 7
#     b. Otherwise, continue
# 5. Answer yourself this question: Did some conditions changed?
#     a. If so, show feedback objects based on the # of conditions (either white or pink; pink because I'm color blind)
#     b. Otherwise, don't do anything
# 6. Go back to Step 3
# 7. Declare the winner (save the score),
#     a. If 0 retries left and the codes aren't matched, codemaker wins!
#     b. If codes matched, codebreaker wins!
# 8. Ask the user to play again
#     a. Yes? Go to Step 2
#     b. Yes, but change the settings. Go to Step 1
#     c. No, end the program, yay!
