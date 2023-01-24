require_relative 'piece'

class Knight < Piece
  attr_reader :piece_id

  def initialize(color)
    super
    @piece_id = :N
  end
end
