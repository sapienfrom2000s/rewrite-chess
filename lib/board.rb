  require_relative 'pieces/piece'
  require_relative 'display'
  require_relative 'coordinates_finder'

class Board
  NO_OF_SQUARES = 64
  attr_accessor :grid
  attr_reader :cursor, :previous_cursor, :squares_to_highlight, :turn, :display, :coordinates_finder, :selected_square

  def initialize
    @grid = {}
    make_grid
    @cursor = [1,1]
    @previous_cursor = [1,1]
    @squares_to_highlight = []
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
    @squares_to_highlight = coordinates_finder.reject_coordinates_that_exposes_own_king
  end

  def transport_piece
    if squares_to_highlight.include?(cursor)
      @grid[cursor] = grid[selected_square]
      display.transport_piece
      remove_cursor_from_hints
      @grid[selected_square] = nil
      switch_turn
    end
  end

  def reset_hints
    @squares_to_highlight = []
  end

  def select_square
    @selected_square = cursor
  end

  def deselect_square
    @selected_square = nil
  end

  def switch_turn
    @turn = turn == :green ? :blue : :green
  end

  private

  def make_grid
    files_and_ranks = *(1..8)
    coordinates = files_and_ranks.repeated_permutation(2).to_a
    @grid = coordinates.to_h { |coord| [coord, nil] }
  end

  def remove_cursor_from_hints
    @squares_to_highlight -= [cursor]
  end
end
