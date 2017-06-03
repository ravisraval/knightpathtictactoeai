require_relative 'tic_tac_toe'
#next_mover_mark = opponent
#if next_mover_mark != original_next_mover_mark, then it's our turn
class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @our_mark = next_mover_mark
    @opponent_mark = (next_mover_mark == :x ? :o : :x)
  end

  def losing_node?(evaluator)
    return true if board.over? && board.winner != next_mover_mark
    return false if board.over? && (board.winner.nil? || board.winner != next_mover_mark)

    if next_mover_mark


  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    potential_boards = []

    dup_board = deep_dup(@board)
    dup_board.rows.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        if cell.empty?
          potential_boards << TicTacToeNode.new(@board, @next_mover_mark = :x ? :o : :x, [row_idx, col_idx])
        end
      end
    end

    potential_boards
  end

  def deep_dup(board)
    board.rows.map { |el| el.is_a? Array ? deep_dup(el) : el }
  end
end
