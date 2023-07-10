
require 'pieces/piece'

class King < Piece

  attr_reader :piece_id, :movement, :image

  def initialize(color)
    super
    @piece_id = :K
    @movement = [[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1],[0,1]]
    @image = '♚ '
  end
end
