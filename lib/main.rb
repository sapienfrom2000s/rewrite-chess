require_relative 'board.rb'
require_relative 'display.rb'
require_relative 'human.rb'
require_relative 'setup.rb'
require_relative 'pieces/rook.rb'
require_relative 'pieces/bishop.rb'

board = Board.new
human = Human.new(board)
board.display.render_board

loop do
    human.move
    board.display.render_board
end