require_relative 'board'
require_relative 'display'
require_relative 'human'
require_relative 'setup'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/king'


board = Board.new
setup = Setup.new(board)
setup.deploy(Rook.new(:green),[[1,1],[8,1]])
setup.deploy(Bishop.new(:green),[[3,1],[6,1]])
setup.deploy(Queen.new(:green),[[4,1]])
setup.deploy(Rook.new(:blue),[[1,8],[8,8]])
setup.deploy(Bishop.new(:blue),[[3,8],[6,8]])
setup.deploy(Queen.new(:blue),[[4,8]])
setup.deploy(Pawn.new(:green),[[1,2],[2,2],[3,2],[4,2],[5,2],[6,2],[7,2],[8,2]])
setup.deploy(Pawn.new(:blue),[[1,7],[2,7],[3,7],[4,7],[5,7],[6,7],[7,7],[8,7]])
setup.deploy(Knight.new(:green),[[2,1],[7,1]])
setup.deploy(Knight.new(:blue),[[2,8],[7,8]])
setup.deploy(King.new(:green),[[5,1]])
setup.deploy(King.new(:blue),[[5,8]])
board.display.mount_pieces
human1 = Human.new(board)
human2 = Human.new(board)
board.display.render_board

loop do
    loop do
        human1.move
        board.display.render_board
        break unless board.turn == :green
    end
    loop do
        human2.move
        board.display.render_board
        break unless board.turn == :blue
    end
end