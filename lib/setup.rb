require_relative 'board'

class Setup
    attr_reader :board

    def initialize(board)
        @board = board
    end

    def deploy(piece, positions)
        positions.each do |coordinate|
          board.grid[coordinate] = piece
        end
    end
end