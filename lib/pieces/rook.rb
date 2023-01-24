require_relative 'piece'

class Rook < Piece
  attr_reader :piece_id

  def initialize(color)
    super
    @piece_id = :R
  end
end
