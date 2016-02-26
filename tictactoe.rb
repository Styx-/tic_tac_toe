class Board

  def initialize
    @board_values = (1..9).to_a.map { |n| n.to_s }
  end

  def slot_occupied?(index)
    @board_values[index] == 'X' || @board_values[index] == 'O'
  end

  def display_board
    puts "_#{@board_values[0]}_|_#{@board_values[1]}_|_#{@board_values[2]}_"
    puts "_#{@board_values[3]}_|_#{@board_values[4]}_|_#{@board_values[5]}_"
    puts " #{@board_values[6]} | #{@board_values[7]} | #{@board_values[8]} "
  end

  def x_move(index)
    @board_values[index] = 'X'
  end

  def o_move(index)
    @board_values[index] = 'O'
  end

  def game_over?
    left_column_taken?      || middle_column_taken?   ||
    right_column_taken?     || top_row_taken?         ||
    middle_row_taken?       || bottom_row_taken?      ||
    bottom_top_diag_taken?  || top_bottom_diag_taken?
  end

  def tie?
    @board_values.each_index do |index|
      return false if !slot_occupied?(index)
    end
    true
  end

  def the_winner
    return @board_values[0] if left_column_taken? || top_row_taken?  || top_bottom_diag_taken?
    return @board_values[1] if middle_column_taken?
    return @board_values[2] if right_column_taken?                  || bottom_top_diag_taken?
    return @board_values[3] if middle_row_taken?
    return @board_values[6] if bottom_row_taken?
    nil
  end

  def left_column_taken?
    return false unless (@board_values[0] == @board_values[3]) &&
                        (@board_values[0] == @board_values[6])
    true
  end

  def middle_column_taken?
    return false unless (@board_values[1] == @board_values[4]) &&
                        (@board_values[1] == @board_values[7])
    true
  end

  def right_column_taken?
    return false unless (@board_values[2] == @board_values[5]) &&
                        (@board_values[2] == @board_values[8])
    true
  end

  def top_row_taken?
    return false unless (@board_values[0] == @board_values[1]) &&
                        (@board_values[0] == @board_values[2])
    true
  end

  def middle_row_taken?
    return false unless (@board_values[3] == @board_values[4]) &&
                        (@board_values[3] == @board_values[5])
    true
  end

  def bottom_row_taken?
    return false unless (@board_values[6] == @board_values[7]) &&
                        (@board_values[6] == @board_values[8])
    true
  end

  def bottom_top_diag_taken?
    return false unless (@board_values[6] == @board_values[4]) &&
                        (@board_values[6] == @board_values[2])
    true
  end

  def top_bottom_diag_taken?
    return false unless (@board_values[0] == @board_values[4]) &&
                        (@board_values[0] == @board_values[8])
    true
  end
end

def ttt_game
  board = Board.new

  puts "Welcome to TicTacToe."

  while true
    board.display_board

    puts "X's where would you like to play?"
    board.x_move(gets.chomp.to_i - 1)

    board.display_board
    break if board.game_over? || board.tie?

    puts "O's where would you like to play?"
    board.o_move(gets.chomp.to_i - 1)

    break if board.game_over? || board.tie?
  end
  if board.tie?
    puts "It was a tie!"
  else
    winner = board.the_winner
    puts "#{winner}'s win!"
  end
end


ttt_game