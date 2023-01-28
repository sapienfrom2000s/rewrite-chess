require_relative 'board.rb'
require_relative 'display.rb'
require_relative 'human.rb'
require_relative 'setup.rb'
require_relative 'pieces/rook.rb'
require_relative 'pieces/bishop.rb'

board = Board.new
human = Human.new(board)
rook = Rook.new(:green)
setup = Setup.new(board)
setup.deploy(rook,[[1,1],[8,1],[7,1]])
display = Display.new(board)


display.render_board
loop do
    human.move
    display.render_board
end