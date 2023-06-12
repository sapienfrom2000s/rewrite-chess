
class Special_Moves
  attr_reader :board, :king_side_castling, :queen_side_castling
  def initialize(board)
    @board = board
    @king_side_castling = {:blue => true, :green => true}
    @queen_side_castling = {:blue => true, :green=> true }
  end

  def break_castle(selected_square)
    piece = board.grid[selected_square]
    break_both_side_castling(piece.color.to_sym) if piece.piece_id == :K
    break_one_side_castling(piece.color.to_sym, selected_square) if piece.piece_id == :R
  end

  private

  def break_both_side_castling(color)
    @king_side_castling[color] = false
    @queen_side_castling[color] = false
  end

  def break_one_side_castling(color, selected_square)
    @king_side_castling[color] = false if rook_init_coordinates[:king_side][color] == selected_square
    @queen_side_castling[color] = false if rook_init_coordinates[:queen_side][color] == selected_square
  end

  def rook_init_coordinates
    {:king_side => {:green => [8,1], :blue => [8,8]}, :queen_side => { :green => [1,1], :blue => [1,8]}}
  end
end