class coordinates_Finder
  MIN_MULTIPLIER = 1
  MAX_MULTIPLIER = 7

  attr_reader :board

  def initialize(board)
      @board = board
  end

  def potential_coordinates(from)
    coordinates = []
    piece = board.grid[from]
    inbound_coordinates = inbound_possible_coordinates(from, piece)
    inbound_coordinates.each do |set|
      set.each do |coordinate|
        current_piece = board.grid[coordinate]
        if current_piece.nil?
          coordinates.push(coordinate)
        elsif current_piece.color == :white
          break
        else
          coordinates.push(coordinate)
          break
        end
      end
    end
    coordinates
  end

  private

  def inbound_possible_coordinates(from, piece)
    coordinates = []
    (piece.movement).each do |relative_move|
      coordinate_subset = []
      (MIN_MULTIPLIER..MAX_MULTIPLIER).each do |multiplier|
        new_coordinate = forge_coordinate(from, rel = amplified_movement(relative_move, multiplier))
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

  def forge_coordinate(from,relative_move)
    [from,relative_move].transpose.map(&:sum)
  end
end