require_relative 'piece'

class Queen < Piece
  attr_reader :piece_id

  def initialize(color)
    super
    @piece_id = :Q
  end
end
