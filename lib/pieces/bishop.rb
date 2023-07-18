require 'pieces/piece'

class Bishop < Piece
  attr_reader :piece_id, :movement, :image

  def initialize(color)
    super
    @piece_id = :B
    @movement = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
    @image = '♝ '
  end
end
