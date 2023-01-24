require_relative 'piece'

class Bishop < Piece
  attr_reader :piece_id

  def initialize(color)
    super
    @piece_id = :B
  end
end
