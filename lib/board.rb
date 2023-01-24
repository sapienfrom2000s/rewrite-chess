class Board
  NO_OF_SQUARES = 64
  attr_accessor :grid

  def initialize(_fen)
    make_grid
  end

  private

  def make_grid(grid = {})
    NO_OF_SQUARES.times do |square_number|
      grid[square_number] = nil
    end
  end
end
