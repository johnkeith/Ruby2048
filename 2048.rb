require 'pry'
require 'rbconfig'
require 'io/console'
# 2048 command line

# create an array of arrays for game board - DONE

# insert a 2 or a 4 into a random place on the board - DONE

# ask for user input - a, s, w, or d

# move pieces on board

# add new random 2 or 4 piece

# break if you reach 2048


game_board = [[" ", " ", " ", " "],
              [" ", " ", " ", " "],
              [" ", " ", " ", " "],
              [" ", " ", " ", " "]]

test_board = [["2", "2", " ", "4"],
              ["2", " ", "4", " "],
              [" ", "2", " ", " "],
              [" ", "4", " ", " "]]

# p test_board

# p test_board.transpose

# p test_board.transpose.transpose

def main_game(start_board)
  while true
    clear_screen
    # display board

    print_board(start_board)

    puts "Score = #{score_board(start_board)}"

    # ask for move
    start_board = ask_for_move(start_board)
    start_board = insert_new(start_board)
  end
end

def print_board(board)
board.each do |row|
    print "|"
    row.each do |item|
      if item.length == 1
        print item + "   |"
      elsif item.length == 2
        print item + "  |"
      elsif item.length == 3
        print item + " |"
      else
        print item
      end
    end
    puts
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

def get_input
  input = ""
  valid = ["w", "a", "s", "d", "q"]
  while !valid.include?(input) do
    input = STDIN.getch
    if input == "\e"
      abort "escaped"
    end
  end
  input
end

def ask_for_move(board)
  puts "Which way do you want to move? (Press 'A', 'S', 'D' or 'W', or 'Q' to quit)"
  
  move = get_input.upcase

  # move = gets.chomp.upcase
  case move
    when "A" then board_after_move=move_left(board)
    when "D" then board_after_move=move_right(board)
    when "S" then board_after_move=move_down(board)
    when "W" then board_after_move=move_up(board)
    when "Q" then abort
  end

  board_after_move
end

# while there is an empty space in the row to the left
def strip_row_left(row)
  row.delete_if {|space| space == " "}
  until row.length == 4
    row.push(" ")
  end
  row
end

def strip_row_right(row)
  row.delete_if {|space| space == " "}
  until row.length == 4
    row.unshift(" ")
  end
  row
end

def move_left(board)
  board.each_with_index do |row, row_idx|
    strip_row_left(row)
    row.each_with_index do |column, col_idx|
      if column == row[col_idx + 1] && !(column == " " )
        board[row_idx][col_idx] = (board[row_idx][col_idx].to_i * 2).to_s
        board[row_idx][col_idx+1] = " "
      else
        next
      end
    end
    strip_row_left(row)
  end
  board
end

def move_right(board)
  board.each_with_index do |row, row_idx|
    strip_row_right(row)
    row.reverse!.each_with_index do |column, col_idx|
      if column == row[col_idx + 1] && !(column == " " )
        board[row_idx][col_idx] = (board[row_idx][col_idx].to_i * 2).to_s
        board[row_idx][col_idx+1] = " "
      else
        next
      end
    end
    row.reverse!
    strip_row_right(row)
  end
  board
end

def move_down(board)
  board = board.transpose
  board.each_with_index do |row, row_idx|
    strip_row_right(row)
    row.reverse!.each_with_index do |column, col_idx|
      if column == row[col_idx + 1] && !(column == " " )
        board[row_idx][col_idx] = (board[row_idx][col_idx].to_i * 2).to_s
        board[row_idx][col_idx+1] = " "
      else
        next
      end
    end
    row.reverse!
    strip_row_right(row)
  end
  board.transpose
end

def move_up(board)
  board = board.transpose
  board.each_with_index do |row, row_idx|
    strip_row_left(row)
    row.each_with_index do |column, col_idx|
      if column == row[col_idx + 1] && !(column == " " )
        board[row_idx][col_idx] = (board[row_idx][col_idx].to_i * 2).to_s
        board[row_idx][col_idx+1] = " "
      else
        next
      end
    end
    strip_row_left(row)
  end
  board.transpose
end

def clear_screen
  host_os = RbConfig::CONFIG['host_os']

  case host_os
    when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
      system "cls"
    when /darwin|mac os|linux|solaris|bsd/
      puts "\e[H\e[2J"
  end
end

# ---- Main ---- #

# pretty_print_board(test_board)

new_board = insert_new(game_board)

main_game = main_game(new_board)
