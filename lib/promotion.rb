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
    piece = get_a_piece
    case piece
    when 'queen'
      board.grid[selected_square] = Queen.new(board.turn)
    when 'rook'
      board.grid[selected_square] = Rook.new(board.turn)      
    when 'bishop'
      board.grid[selected_square] = Bishop.new(board.turn)
    else
      board.grid[selected_square] = Knight.new(board.turn)
    end
  end

  def get_a_piece
    loop do
      puts "Type queen, knight, bishop or rook for promotion"
      input = gets.chomp
      return input if %w(queen knight bishop rook).include?(input)
    end
  end
end