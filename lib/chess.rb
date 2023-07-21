$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'board'
require 'display'
require 'human'
require 'setup'
require 'pieces/rook'
require 'pieces/bishop'
require 'pieces/queen'
require 'pieces/pawn'
require 'pieces/knight'
require 'pieces/king'


board = Board.new
setup = Setup.new(board)
setup.deploy(Rook.new(:white), [[1, 1], [8, 1]])
setup.deploy(Bishop.new(:white), [[3, 1], [6, 1]])
setup.deploy(Queen.new(:white), [[4, 1]])
setup.deploy(Rook.new(:black), [[1, 8], [8, 8]])
setup.deploy(Bishop.new(:black), [[3, 8], [6, 8]])
setup.deploy(Queen.new(:black), [[4, 8]])
setup.deploy(Pawn.new(:white), [[1, 2], [2, 2], [3, 2],
 [4, 2], [5, 2], [6, 2], [7, 2], [8, 2]])
setup.deploy(Pawn.new(:black), [[1, 7], [2, 7], [3, 7],
 [4, 7], [5, 7], [6, 7], [7, 7], [8, 7]])
setup.deploy(Knight.new(:white), [[2, 1], [7, 1]])
setup.deploy(Knight.new(:black), [[2, 8], [7, 8]])
setup.deploy(King.new(:white), [[5, 1]])
setup.deploy(King.new(:black), [[5, 8]])
board.display.mount_pieces
human1 = Human.new(board)
human2 = Human.new(board)
board.display.render_board

loop do
  loop do
    human1.move
    board.display.render_board
    break unless board.turn == :white
  end
  loop do
    human2.move
    board.display.render_board
    break unless board.turn == :black
  end
end
