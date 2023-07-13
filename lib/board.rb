require 'pieces/piece'
require 'display'
require 'coordinates_finder'
require 'castling'
require 'promotion'

class Board

  include Coordinates_Finder

  NO_OF_SQUARES = 64
  INIT_ROOK_COORDINATES = [[1, 1], [1, 8], [8, 1], [8, 8]]
  INIT_KING_COORDINATES = [[5, 1], [5, 8]]
  attr_accessor :grid
  attr_reader :cursor, :previous_cursor, :squares_to_highlight, :turn, :display, :selected_square, :castle, :promotion

  def initialize
    @grid = {}
    make_grid
    @cursor = [1, 1]
    @previous_cursor = [1, 1]
    @squares_to_highlight = []
    @display = Display.new(self)
    @turn = :green
    @castle = Castling.new(self)
    @promotion = Promotion.new(self)
    @board = self
  end

  def update_cursor(relative_move)
    updated_cursor = [cursor,relative_move].transpose.map(&:sum)
    if updated_cursor.first.between?(1, 8) &&\
     updated_cursor.last.between?(1, 8)
      @cursor = updated_cursor
    end
  end

  def save_cursor
    @previous_cursor = cursor
  end

  def fill_hints
    return if grid[cursor].nil?
    @squares_to_highlight = potential_coordinates(cursor)
    @squares_to_highlight = reject_coordinates_that_exposes_own_king
  end

  def transport_piece
    if squares_to_highlight.include?(cursor)
      castle.break(selected_square) if rook_or_king_is_being_moved?
      promotion.mutate_pawn(selected_square) if grid[selected_square].piece_id == :P && (cursor.last == 1 || cursor.last == 8)

      @grid[cursor] = grid[selected_square]
      display.transport_piece
      remove_cursor_from_hints

      @grid[selected_square] = nil
      switch_turn
    end
  end

  def castle_kingside
    return unless castle.kingside_possible?
    king_init_coordinate = castle.king_init_coordinates[turn]
    manual_piece_lift(king_init_coordinate.zip([2, 0]).map(&:sum), king_init_coordinate)
    manual_piece_lift(king_init_coordinate.zip([1, 0]).map(&:sum), king_init_coordinate.zip([3, 0]).map(&:sum))
    castle.break_both_side(turn)
    switch_turn
  end

  def castle_queenside
    return unless castle.queenside_possible?
    king_init_coordinate = castle.king_init_coordinates[turn]
    manual_piece_lift(king_init_coordinate.zip([-2, 0]).map(&:sum), king_init_coordinate)
    manual_piece_lift(king_init_coordinate.zip([-1, 0]).map(&:sum), king_init_coordinate.zip([-4, 0]).map(&:sum))
    castle.break_both_side(turn)
    switch_turn
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

  def manual_piece_lift(cursor, selected_square)
    @cursor = cursor
    @previous_cursor = previous_cursor
    @selected_square = selected_square
    @grid[cursor] = grid[selected_square]
    display.transport_piece

    @grid[selected_square] = nil
  end

  def make_grid
    files_and_ranks = *(1..8)
    coordinates = files_and_ranks.repeated_permutation(2).to_a
    @grid = coordinates.to_h { |coord| [coord, nil] }
  end

  def remove_cursor_from_hints
    @squares_to_highlight -= [cursor]
  end

  def rook_or_king_is_being_moved?
    piece_id = self.grid[selected_square].piece_id
    (piece_id == :R || piece_id == :K) && (INIT_KING_COORDINATES + INIT_ROOK_COORDINATES).include?(selected_square)
  end
end
