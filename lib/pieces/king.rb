require_relative 'piece'

class King < Piece
  attr_reader :piece_id

  def initialize(color)
    super
    @piece_id = :K
  end
end
