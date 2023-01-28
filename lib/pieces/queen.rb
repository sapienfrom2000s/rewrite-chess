require_relative 'piece'

class Queen < Piece
  MOVEMENT = [[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1],[0,1]]
  attr_reader :piece_id

  def initialize(color, board)
    super
    @piece_id = :Q
  end
end
