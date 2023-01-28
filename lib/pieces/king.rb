require_relative 'piece'

class King < Piece
  MOVEMENT = [[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1],[0,1]]
  attr_reader :piece_id

  def initialize(color, board)
    super
    @piece_id = :K
  end
end
