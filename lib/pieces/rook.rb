require 'pieces/piece'

class Rook < Piece

  attr_reader :piece_id, :movement, :image

  def initialize(color)
    super
    @piece_id = :R
    @movement = [[1, 0], [0, -1], [-1, 0], [0, 1]]
    @image = '♜ '
  end
end
