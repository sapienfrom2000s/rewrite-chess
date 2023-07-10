require 'pieces/piece'

class Queen < Piece

  attr_reader :piece_id, :movement, :image

  def initialize(color)
    super
    @piece_id = :Q
    @movement = [[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1],[0,1]]
    @image = '♛ '
  end
end
