require_relative '../lib/board'
require_relative '../lib/setup'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/king'

describe Board do
    let(:board) { Board.new }
    let(:setup) { Setup.new(board) }
    context 'when blue bishop is on [4,4],green knight on [5,5] and green king on [7,7] and knight tries to move' do
        it 'returns no highlighted squares' do
            bishop = Bishop.new(:blue)
            knight = Knight.new(:green)
            king = King.new(:green)
            setup.deploy(bishop, [[4, 4]])
            setup.deploy(knight, [[5, 5]])
            setup.deploy(king, [[7, 7]])
            board.potential_coordinates([5, 5])
            allow(board).to receive(:squares_to_highlight){[[3, 4], [3, 6], [4, 3], [4, 7], [6, 3], [6, 7], [7, 4], [7, 6]]}
            expect(board.reject_coordinates_that_exposes_own_king).to eq([])
        end
    end

    context 'when blue bishop is on [7,2],green queen on [2, 7] and green king on [1, 8] and queen tries to move' do
        it 'returns array of squares it can go' do
            bishop = Bishop.new(:blue)
            queen = Queen.new(:green)
            king = King.new(:green)
            setup.deploy(bishop, [[7, 2]])
            setup.deploy(queen, [[2, 7]])
            setup.deploy(king, [[1, 8]])
            board.potential_coordinates([2, 7])
            allow(board).to receive(:squares_to_highlight) {[[1, 6], [3, 8], [3, 6], [4, 5], [5, 4], [6, 3], [7, 2]]}
            expect(board.reject_coordinates_that_exposes_own_king).to eq([[3, 6], [4, 5], [5, 4], [6, 3], [7, 2]])
        end
    end

    context 'when blue bishop is on [7,2], green king on [1, 8] and king tries to move' do
        it 'returns array of squares it can go' do
            bishop = Bishop.new(:blue)
            king = King.new(:green)
            setup.deploy(bishop, [[7, 2]])
            setup.deploy(king, [[1, 8]])
            board.potential_coordinates([1, 8])
            allow(board).to receive(:squares_to_highlight) {[[1, 7], [2, 7], [2, 8]]}
            expect(board.reject_coordinates_that_exposes_own_king).to eq([[1, 7], [2, 8]])
        end
    end

    context 'when blue bishop is on [7,2], blue queen on [2,7] green king on [1, 8] and king tries to move' do
        it 'returns array of squares it can go' do
            bishop = Bishop.new(:blue)
            king = King.new(:green)
            queen = Queen.new(:blue)
            setup.deploy(bishop, [[7, 2]])
            setup.deploy(king, [[1, 8]])
            setup.deploy(queen, [[2, 7]])
            board.potential_coordinates([1, 8])
            allow(board).to receive(:squares_to_highlight) {[[1, 7], [2, 7], [2, 8]]}
            expect(board.reject_coordinates_that_exposes_own_king).to eq([])
        end
    end


    context 'when blue bishop is on [8,3], blue queen on [5,1] green king on [4, 8] and king tries to move' do
        it 'returns array of squares it can go' do
            bishop = Bishop.new(:blue)
            king = King.new(:green)
            queen = Queen.new(:blue)
            setup.deploy(bishop, [[8, 3]])
            setup.deploy(king, [[4, 8]])
            setup.deploy(queen, [[5, 1]])
            board.potential_coordinates([4, 8])
            allow(board).to receive(:squares_to_highlight) {[[3, 8], [5, 8], [3, 7], [4, 7], [5, 7]]}
            expect(board.reject_coordinates_that_exposes_own_king).to eq([[3, 7]])
        end
    end

    context 'when blue bishop is on [8,3], blue queen on [4,1] green king on [4, 8], green rook on [8,7] and king tries to move' do
        it 'returns array of squares it can go' do
            bishop = Bishop.new(:blue)
            king = King.new(:green)
            rook = Rook.new(:green)
            queen = Queen.new(:blue)
            setup.deploy(bishop, [[8, 3]])
            setup.deploy(king, [[4, 8]])
            setup.deploy(queen, [[4, 1]])
            setup.deploy(rook, [[8, 7]])
            board.potential_coordinates([8, 7])
            allow(board).to receive(:squares_to_highlight) {[[1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7], [7, 7], [8, 7]]}
            expect(board.reject_coordinates_that_exposes_own_king).to eq([[4, 7]])
        end
    end

    context 'when blue bishop is on [8, 3], blue queen on [4,1] green king on [4, 8], green rook on [8,1] and king tries to move' do
        it 'returns array of squares it can go' do
            bishop = Bishop.new(:blue)
            king = King.new(:green)
            rook = Rook.new(:green)
            queen = Queen.new(:blue)
            setup.deploy(bishop, [[8, 3]])
            setup.deploy(king, [[4, 8]])
            setup.deploy(queen, [[4, 1]])
            setup.deploy(rook, [[8, 1]])
            board.potential_coordinates([8, 1])
            allow(board).to receive(:squares_to_highlight) {[[7, 1], [6, 1], [5, 1], [4, 1]]}
            expect(board.reject_coordinates_that_exposes_own_king).to eq([[4, 1]])
        end
    end

    context 'when blue bishop is on [8,3], blue queen on [5,1] green king on [5, 6], green rook on [8,1] and king tries to move' do
        it 'returns array of squares it can go' do
            bishop = Bishop.new(:blue)
            king = King.new(:green)
            rook = Rook.new(:green)
            queen = Queen.new(:blue)
            setup.deploy(bishop, [[8, 3]])
            setup.deploy(king, [[5, 6]])
            setup.deploy(queen, [[5, 1]])
            setup.deploy(rook, [[8, 1]])
            board.potential_coordinates([8, 1])
            allow(board).to receive(:squares_to_highlight) {[[7, 1], [6, 1], [5, 1], [4, 1], [5, 1]]}
            expect(board.reject_coordinates_that_exposes_own_king).to eq([])
        end
    end
end