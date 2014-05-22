require 'rbconfig'
require 'io/console'

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

def clear_screen
  host_os = RbConfig::CONFIG['host_os']

  case host_os
    when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
      system "cls"
    when /darwin|mac os|linux|solaris|bsd/
      puts "\e[H\e[2J"
  end
end
