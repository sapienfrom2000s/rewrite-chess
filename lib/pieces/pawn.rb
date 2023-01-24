require_relative 'piece'

class Pawn < Piece
  attr_reader :piece_id

  def initialize(color)
    super
    @piece_id = :P
  end
end
