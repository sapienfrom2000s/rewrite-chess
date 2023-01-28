  require_relative 'pieces/piece.rb'

class Board
  NO_OF_SQUARES = 64
  attr_accessor :grid
  attr_reader :cursor, :previous_cursor

  def initialize
    @grid = {}
    make_grid
    @cursor = [1,1]
    @previous_cursor = [1,1]
  end

  def update_cursor(relative_move)
    updated_cursor = [cursor,relative_move].transpose.map(&:sum)
    if updated_cursor.first.between?(1,8) &&\
     updated_cursor.last.between?(1,8)
     @cursor = updated_cursor
    end
  end

  def save_cursor
    @previous_cursor = cursor
  end

  private

  def make_grid
    files_and_ranks = *(1..8)
    coordinates = files_and_ranks.repeated_permutation(2).to_a
    @grid = coordinates.to_h { |coord| [coord, nil] }
  end
end
