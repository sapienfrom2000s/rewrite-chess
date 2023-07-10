

module Coordinates_Finder

  attr_reader :board, :from, :current_king_coordinate

  def potential_coordinates(from)
    @from = from
    piece_id = board.grid[from].piece_id
    case piece_id
    when :B, :R, :Q
      get_potential_coordinates_of_piece_wrt_range((1..7))
    when :P
      get_potential_coordinates_of_pawn_without_capture + 
      get_potential_pawn_captures
    else
      get_potential_coordinates_of_piece_wrt_range((1..1))
    end
  end

  def reject_coordinates_that_exposes_own_king
    @current_king_coordinate = get_current_king_coordinate
    current_piece_id = board.grid[from].piece_id
    board.squares_to_highlight.reject do |highlighted_square|
      update_king_coordinate(highlighted_square) if current_piece_id == :K
      current_king_exposed?(highlighted_square)
    end
  end

  private

  def get_potential_coordinates_of_piece_wrt_range(range)
    coordinates = []
    board_grid = board.grid
    piece = board_grid[from]
    inbound_coordinates = inbound_possible_coordinates(piece, range)
    inbound_coordinates.each do |set|
      set.each do |coordinate|
        current_piece = board_grid[coordinate]
        if current_piece.nil?
          coordinates.push(coordinate)
        elsif current_piece.color == board.turn
          break
        else
          coordinates.push(coordinate)
          break
        end
      end
    end
    coordinates
  end

  def get_potential_coordinates_of_pawn_without_capture
    rank = from.last
    color = board.grid[from].color
    param = color_based_variables(color)
    if rank == param[:starting_rank]
      filter_samefile_and_nil_coords(get_potential_coordinates_of_piece_wrt_range(amplified_movement([1,2],param[:flipper])))
    else
      filter_samefile_and_nil_coords(get_potential_coordinates_of_piece_wrt_range(amplified_movement([1],param[:flipper])))
    end
  end

  def color_based_variables(color)
    color == :green ? {:starting_rank=>2,:flipper=>1} : {:starting_rank=>7,:flipper=>-1}
  end

  def get_potential_pawn_captures
    color = board.grid[from].color
    param = color_based_variables(color)
    filter_difffile_and_nonnil_coords(get_potential_coordinates_of_piece_wrt_range(amplified_movement([1],param[:flipper])))
  end

  def filter_difffile_and_nonnil_coords(coordinates)
    coordinates.filter do |coordinate|
      board.grid[coordinate].nil? == false && coordinate.first != from.first
    end
  end

  def filter_samefile_and_nil_coords(coordinates)
    coordinates.filter do |coordinate|
      board.grid[coordinate].nil? && coordinate.first == from.first
    end
  end

  def inbound_possible_coordinates(piece, range)
    coordinates = []
    (piece.movement).each do |relative_move|
      coordinate_subset = []
      range.each do |multiplier|
        new_coordinate = forge_coordinate(rel = amplified_movement(relative_move, multiplier))
        break unless new_coordinate.first.between?(1,8) && new_coordinate.last.between?(1,8) 
        coordinate_subset.push(new_coordinate)
      end
      coordinates.push(coordinate_subset) 
    end
    coordinates
  end

  def amplified_movement(relative_move, multiplier)
    relative_move.map{|elt| elt*multiplier}
  end

  def forge_coordinate(relative_move)
    [from,relative_move].transpose.map(&:sum)
  end

  #this method is expensive and can be substituted
  def get_squares_occupied_by_current_turn
    current_turn = board.turn
    board.grid.reject do |coordinate, value|
      value.nil? || value.color != current_turn
    end.keys
  end
  
  def current_king_exposed?(highlighted_square)
    pseudo_move(highlighted_square)
    board.switch_turn 
    flag = get_squares_occupied_by_current_turn.any? do |coordinate|
      potential_coordinates(coordinate).include?(current_king_coordinate)
    end
    board.switch_turn
    undo_move(highlighted_square)
    flag
  end

  def update_king_coordinate(highlighted_square)
    @current_king_coordinate = highlighted_square
  end

  def pseudo_move(highlighted_square)
    @piece_backup = board.grid[highlighted_square]
    @from_backup = from
    board.grid[highlighted_square] = board.grid[from]
    board.grid[from] = nil
  end

  def undo_move(highlighted_square)
    @from = @from_backup
    board.grid[from] = board.grid[highlighted_square]
    board.grid[highlighted_square] = @piece_backup 
  end

  #this method is expensive and can be substituted
  def get_current_king_coordinate
    current_turn = board.turn
    board.grid.reject do |coordinate, value|
      value.nil? || value.piece_id != :K || value.color != current_turn 
    end.keys.flatten
  end

  protected

  def get_squares_occupied_by_current_turn
    current_turn = board.turn
    board.grid.reject do |coordinate, value|
      value.nil? || value.color != current_turn
    end.keys
  end
end