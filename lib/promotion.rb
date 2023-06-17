require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/rook'
require_relative 'pieces/queen'

class Promotion
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def mutate_pawn(selected_square)
    piece = select_piece
    board.grid[selected_square] = forge_the_piece(piece)
  end

  private

  def forge_the_piece(piece)
    case piece
    when 'queen'
      Queen.new(board.turn)
    when 'rook'
      Rook.new(board.turn)
    when 'bishop'
      Bishop.new(board.turn)
    else
      Knight.new(board.turn)
    end
  end

  def select_piece
    loop do
      puts 'Type queen, knight, bishop or rook for promotion'
      input = gets.chomp
      return input if %w[queen knight bishop rook].include?(input)
    end
  end
end
