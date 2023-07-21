require 'pieces/piece'

class Knight < Piece

  attr_reader :piece_id, :movement, :image

  def initialize(color)
    super
    @piece_id = :N
    @movement = [[-1, 2], [1, 2], [2, 1], [2, -1],
                [1, -2], [-1, -2], [-2, -1], [-2, 1]]
    @image = '♞ '
  end
end
