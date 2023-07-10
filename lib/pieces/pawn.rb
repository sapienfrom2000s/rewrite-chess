require 'pieces/piece'

class Pawn < Piece
  attr_reader :piece_id, :movement, :image

  def initialize(color)
    super
    @piece_id = :P
    @movement = [[0, 1], [1, 1], [-1, 1]]
    @image = '♟ '
  end
end


