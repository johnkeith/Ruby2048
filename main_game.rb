require_relative 'console_methods'
require_relative 'move_methods'

game_board = [[" ", " ", " ", " "],
              [" ", " ", " ", " "],
              [" ", " ", " ", " "],
              [" ", " ", " ", " "]]

def main_game(start_board)
  while true
    clear_screen
    # display board

    print_board(start_board)

    puts "\nScore = #{score_board(start_board)}\n\n"

    # ask for move
    start_board = ask_for_move(start_board)
    start_board = insert_new(start_board)
  end
end

def score_board(board)
  score = 0
  board.each do |row|
    score += row.map(&:to_i).inject(:+)
  end
  score
end

def insert_new(board)
  successful = false
  while !successful
    random_position_one = rand(4)
    random_position_two = rand(4)
    two_or_four= rand(2) == 1 ? "2" : "4"
    if board[random_position_one][random_position_two] == " "
      board[random_position_one][random_position_two] = two_or_four
      successful = true
    end
  end
  board
end

# ---- Main ---- #

new_board = insert_new(game_board)

main_game = main_game(new_board)
