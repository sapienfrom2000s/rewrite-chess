  require_relative 'pieces/piece'
  require_relative 'display'
  require_relative 'squares_finder'

class Board
  NO_OF_SQUARES = 64
  attr_accessor :grid
  attr_reader :cursor, :previous_cursor, :squares_to_highlight, :display, :turn, :display, :coordinates_finder

  def initialize
    @grid = {}
    make_grid
    @cursor = [1,1]
    @previous_cursor = [1,1]
    @squares_to_highlight = []
    setup = Setup.new(self)
    setup.deploy(Rook.new(:green),[[1,1],[8,1]])
    setup.deploy(Bishop.new(:green),[[3,1],[6,1]])
    @display = Display.new(self)
    @turn = :green
    @coordinates_finder = Coordinates_Finder.new(self)
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

  def fill_hints
    return if grid[cursor].nil?
    @squares_to_highlight = coordinates_finder.potential_coordinates(cursor)
  end

  def transport_piece
    if squares_to_highlight.include?(cursor)
      @grid[cursor] = grid[previous_cursor]
      display.transport_piece
      @grid[previous_cursor] = nil
    end
  end

  def reset_hints
    @squares_to_highlight = []
  end

  private

  def make_grid
    files_and_ranks = *(1..8)
    coordinates = files_and_ranks.repeated_permutation(2).to_a
    @grid = coordinates.to_h { |coord| [coord, nil] }
  end
end
