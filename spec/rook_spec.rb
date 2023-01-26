require_relative '../lib/pieces/rook'
require_relative '../lib/board'
require_relative '../lib/setup'
require_relative '../lib/squares_finder'



describe Rook do
    let(:board) { Board.new }
    let(:setup) { Setup.new(board) }

    context 'When rook is at square [1,1]' do
        it 'will give an array of squares it can go to' do
            rook = Rook.new(:white)
            setup.deploy(rook,[[1,1]])
            squares_finder = Squares_Finder.new(board)
            expect(squares_finder.potential_squares([1,1])).to eq([[2,1],[3,1],[4,1],[5,1],[6,1],[7,1],[8,1],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8]])
        end
    end

    context 'When rook is at square [5,6]' do
        it 'will give an array of squares it can go to' do
            rook = Rook.new(:white)
            setup.deploy(rook,[[5,6]])
            squares_finder = Squares_Finder.new(board)
            expect(squares_finder.potential_squares([5,6])).to eq([[6,6],[7,6],[8,6],[5,5],[5,4],[5,3],[5,2],[5,1],[4,6],[3,6],[2,6],[1,6],[5,7],[5,8]])
        end
    end

    context 'When rook is at square [5,6] and a same side rook obstructs the path by three sides' do
        it 'will give an array of squares it can go to' do
            rook = Rook.new(:white)
            setup.deploy(rook,[[5,6],[5,7],[5,5],[4,6]])
            squares_finder = Squares_Finder.new(board)
            expect(squares_finder.potential_squares([5,6])).to eq([[6,6],[7,6],[8,6]])
        end
    end

    context 'When rook is at square 0 and a same side rook obstructs the path and opp side rook obstructs path at [6,6]' do
        it 'will give an array of squares it can go to' do
            rook1 = Rook.new(:white)
            rook2 = Rook.new(:black)
            setup.deploy(rook1,[[5,6],[5,7],[5,5],[4,6]])
            setup.deploy(rook2,[[6,6]])
            squares_finder = Squares_Finder.new(board)
            expect(squares_finder.potential_squares([5,6])).to eq([[6,6]])
        end
    end
end