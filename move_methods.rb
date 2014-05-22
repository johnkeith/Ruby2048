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
