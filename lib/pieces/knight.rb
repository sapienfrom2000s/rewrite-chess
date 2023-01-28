require_relative 'piece'

class Knight < Piece
  MOVEMENT = [[-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1]]
  attr_reader :piece_id

  def initialize(color, board)
    super
    @piece_id = :N
  end
end
