require 'io/console'

class Human

  attr_reader :board

  def initialize(board)
    @board = board
  end

  MOVES = {
    'w' => ->(board) { board.update_cursor([ 0,  1]) },
    'W' => ->(board) { board.update_cursor([ 0,  2]) },
    's' => ->(board) { board.update_cursor([ 0, -1]) },
    'S' => ->(board) { board.update_cursor([ 0, -2]) },
    'a' => ->(board) { board.update_cursor([-1,  0]) },
    'A' => ->(board) { board.update_cursor([-2,  0]) },
    'd' => ->(board) { board.update_cursor([ 1,  0]) },
    'D' => ->(board) { board.update_cursor([ 2,  0]) },
    'k' => ->(board) { board.castle_kingside },
    'q' => ->(board) { board.castle_queenside },
    'e' => proc { exit }
  }

  def move
    keypress = STDIN.getch
    case keypress
    when *MOVES.keys
      MOVES[keypress][board]
    when "\r"
      current_piece = board.grid[board.cursor]
      if (current_piece && current_piece.color == board.turn )
        board.display.decolorize_hints
        board.select_square
        board.fill_hints
        board.display.colorize_hints
      else
        board.transport_piece
        board.display.decolorize_hints
        board.reset_hints
        board.deselect_square
      end
    end
  end
end
