
class Castling < Coordinates_Finder
  attr_reader :board, :king_side, :queen_side
  def initialize(board)
    @board = board
    @king_side = {:blue => true, :green => true}
    @queen_side = {:blue => true, :green=> true }
  end

  def break(selected_square)
    piece = board.grid[selected_square]
    break_both_side(piece.color.to_sym) if piece.piece_id == :K
    break_one_side(piece.color.to_sym, selected_square) if piece.piece_id == :R
  end

  def kingside
    return unless kingside_available? && no_pieces_between?(:king, :king_rook) && opponent_piece_vision_not_between?(:king, :king_rook)
    board.grid[]

  end

  private

  def break_both_side(color)
    @king_side[color] = false
    @queen_side[color] = false
  end

  def break_one_side(color, selected_square)
    @king_side[color] = false if rook_init_coordinates[:king_side][color] == selected_square
    @queen_side[color] = false if rook_init_coordinates[:queen_side][color] == selected_square
  end

  def rook_init_coordinates
    {:king_side => {:green => [8,1], :blue => [8,8]}, :queen_side => { :green => [1,1], :blue => [1,8]}}
  end

  def king_init_coordinates
    {:green => [5,1], :blue => [5,8]}
  end

  def kingside_available?
    king_side[board.turn]
  end

  def no_pieces_between?(king, rook)
    color = board.turn
    if rook == :king_rook
      king_rook_coordinate = rook_init_coordinates[:king_side][color]
      board.grid[king_rook_coordinate-[2,0]].nil? && potential_coordinates(king_rook_coordinate).include?(king_rook_coordinate-[2,0])
    else
    end
  end

  def opponent_piece_vision_not_between?(king, rook)
    key_squares = key_squares_between(king, rook)
    board.switch_turn
    flag = get_squares_occupied_by_current_turn.none? do |coordinate|
      from = coordinate
      potential_coordinates(from).intersect?(key_squares)
    end
    board.switch_turn
    flag
  end

  def key_squares_between(king, rook)
    key_squares = []
    if rook == :king_rook
      3.times do |file_adder|
        key_squares << king_init_coordinates[board.turn] + [file_adder,0]
      end
    else
      4.times do |file_adder|
        key_squares << king_init_coordinates[board.turn] - [file_adder,0]
      end
    end
  end
end