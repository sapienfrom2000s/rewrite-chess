require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/rook'
require_relative '../lib/board'
require_relative '../lib/setup'
require_relative '../lib/coordinates_finder'
require 'pry-byebug'

describe Pawn do
    let(:board) { Board.new }
    let(:setup) { Setup.new(board) }

    context 'When white pawn is at square [1,2]' do
        it 'will give an array of squares it can go to' do
            pawn = Pawn.new(:green)
            setup.deploy(pawn,[[1,2]])
            expect(board.potential_coordinates([1,2])).to eq([[1,3],[1,4]])
        end
    end

    context 'When white pawn is at square [5, 2]' do
        it 'will give an array of squares it can go to' do
            pawn = Pawn.new(:green)
            setup.deploy(pawn,[[5,2]])
            expect(board.potential_coordinates([5,2])).to eq([[5,3], [5,4]])
        end
    end

    context 'When white pawn is at square [5, 3]' do
        it 'will give an array of squares it can go to' do
            pawn = Pawn.new(:green)
            setup.deploy(pawn,[[5,3]])
            expect(board.potential_coordinates([5,3])).to eq([[5,4]])
        end
    end

    context 'When white pawn is at square [8, 6]' do
        it 'will give an array of squares it can go to' do
            pawn = Pawn.new(:green)
            setup.deploy(pawn,[[8,6]])
            expect(board.potential_coordinates([8,6])).to eq([[8,7]])
        end
    end

    context 'When white pawn is at square [5, 2]' do
        it 'will give an array of squares it can go to' do
            pawn = Pawn.new(:green)
            setup.deploy(pawn,[[5,2]])
            expect(board.potential_coordinates([5,2])).to eq([[5,3], [5,4]])
        end
    end

    context 'When white pawn is at square [5,2] and a same side piece obstructs the path by' do
        it 'will give an array of squares it can go to' do
            pawn = Pawn.new(:green)
            rook = Rook.new(:green)
            setup.deploy(pawn,[[5,2]])
            setup.deploy(rook,[[5,4]])
            expect(board.potential_coordinates([5,2])).to eq([[5,3]])
        end
    end

    context 'When pawn is at square [5,2] and a same side pawn obstructs the path and opp side pawn obstructs path at [5,3]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:green)
            pawn2 = Pawn.new(:blue)
            setup.deploy(pawn1,[[5,2]])
            setup.deploy(pawn2,[[5,3]])
            expect(board.potential_coordinates([5,2])).to eq([])
        end
    end

    context 'When pawn is at square [7,5] and a same side pawn obstructs the path and opp side pawn obstructs path at [7, 6]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:green)
            pawn2 = Pawn.new(:blue)
            setup.deploy(pawn1,[[7, 5]])
            setup.deploy(pawn2,[[7, 6]])
            expect(board.potential_coordinates([7, 5])).to eq([])
        end
    end
end

#captures in pawns

describe Pawn do
    let(:board) { Board.new }
    let(:setup) { Setup.new(board) }

    context 'When green pawn is at square [1,2] and blue pawn is at [2,3]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:green)
            pawn2 = Pawn.new(:blue)
            setup.deploy(pawn1,[[1,2]])
            setup.deploy(pawn2,[[2,3]])
            expect(board.potential_coordinates([1,2])).to eq([[1,3],[1,4],[2,3]])
        end
    end

    context 'When green pawn is at square [1,2] and blue pawn is at [2,3]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:green)
            pawn2 = Pawn.new(:blue)
            setup.deploy(pawn1,[[1,2]])
            setup.deploy(pawn2,[[2,4]])
            expect(board.potential_coordinates([1,2])).to eq([[1,3],[1,4]])
        end
    end

    context 'When green pawn is at square [1,2] and green pawn is at [2,3]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:green)
            pawn2 = Pawn.new(:blue)
            setup.deploy(pawn1,[[1,2]])
            setup.deploy(pawn1,[[2,3]])
            expect(board.potential_coordinates([1,2])).to eq([[1,3],[1,4]])
        end
    end

    context 'When green pawn is at square [1,2] and blue pawn is at [2,4]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:green)
            pawn2 = Pawn.new(:blue)
            setup.deploy(pawn1,[[1,2]])
            setup.deploy(pawn2,[[2,4]])
            expect(board.potential_coordinates([1,2])).to eq([[1,3],[1,4]])
        end
    end

    context 'When green pawn is at square [6,6] and blue pawn is at [7,7] and [5,7]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:green)
            pawn2 = Pawn.new(:blue)
            setup.deploy(pawn1,[[6,6]])
            setup.deploy(pawn2,[[7,7],[5,7]])
            expect(board.potential_coordinates([6,6])).to eq([[6,7],[7,7],[5,7]])
        end
    end
end



describe Pawn do
    let(:board) { Board.new }
    let(:setup) { Setup.new(board) }

    context 'When black pawn is at square [1,7]' do
        it 'will give an array of squares it can go to' do
            pawn = Pawn.new(:blue)
            setup.deploy(pawn,[[1,7]])
            allow(board).to receive(:turn) {:blue} 
            expect(board.potential_coordinates([1,7])).to eq([[1,6],[1,5]])
        end
    end

    context 'When black pawn is at square [5, 7]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:blue)
            pawn2 = Pawn.new(:green)
            setup.deploy(pawn1,[[5,7]])
            setup.deploy(pawn2,[[4,6],[4,5]])
            allow(board).to receive(:turn) {:blue}
            expect(board.potential_coordinates([5,7])).to eq([[5,6], [5,5],[4,6]])
        end
    end

    context 'When black pawn is at square [5, 6]' do
        it 'will give an array of squares it can go to' do
            pawn = Pawn.new(:blue)
            setup.deploy(pawn,[[5,6]])
            allow(board).to receive(:turn) {:blue}
            expect(board.potential_coordinates([5,6])).to eq([[5,5]])
        end
    end

    context 'When black pawn is at square [8, 6]' do
        it 'will give an array of squares it can go to' do
            pawn = Pawn.new(:blue)
            setup.deploy(pawn,[[8,6]])
            allow(board).to receive(:turn) {:blue}
            expect(board.potential_coordinates([8,6])).to eq([[8,5]])
        end
    end

    context 'When black pawn is at square [5, 7]' do
        it 'will give an array of squares it can go to' do
            pawn = Pawn.new(:blue)
            setup.deploy(pawn,[[5,7]])
            allow(board).to receive(:turn) {:blue}
            expect(board.potential_coordinates([5,7])).to eq([[5,6], [5,5]])
        end
    end

    context 'When black pawn is at square [5,7] and a same side piece obstructs the path by' do
        it 'will give an array of squares it can go to' do
            pawn = Pawn.new(:blue)
            rook = Rook.new(:blue)
            setup.deploy(pawn,[[5,7]])
            setup.deploy(rook,[[5,5]])
            allow(board).to receive(:turn) {:blue}
            expect(board.potential_coordinates([5,7])).to eq([[5,6]])
        end
    end

    context 'When pawn is at square [5,7] and a same side pawn obstructs the path and opp side pawn obstructs path at [5,6]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:blue)
            pawn2 = Pawn.new(:green)
            setup.deploy(pawn1,[[5,7]])
            setup.deploy(pawn2,[[5,6]])
            allow(board).to receive(:turn) {:blue}
            expect(board.potential_coordinates([5,7])).to eq([])
        end
    end

    context 'When pawn is at square [7,5] and a same side pawn obstructs the path and opp side pawn obstructs path at [7, 6]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:blue)
            pawn2 = Pawn.new(:green)
            setup.deploy(pawn1,[[7, 5]])
            setup.deploy(pawn2,[[7, 4]])
            allow(board).to receive(:turn) {:blue}
            expect(board.potential_coordinates([7, 4])).to eq([])
        end
    end
end

#captures in pawns

describe Pawn do
    let(:board) { Board.new }
    let(:setup) { Setup.new(board) }

    context 'When green pawn is at square [5, 7] and blue pawn is at [4,6]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:blue)
            pawn2 = Pawn.new(:green)
            setup.deploy(pawn1,[[5, 7]])
            setup.deploy(pawn2,[[4, 6]])
            allow(board).to receive(:turn) {:blue}
            expect(board.potential_coordinates([5, 7])).to eq([[5,6],[5, 5],[4, 6]])
        end
    end

    context 'When green pawn is at square [1,2] and blue pawn is at [2,3]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:blue)
            pawn2 = Pawn.new(:blue)
            setup.deploy(pawn1,[[5, 7]])
            setup.deploy(pawn2,[[4, 5]])
            allow(board).to receive(:turn) {:blue}
            expect(board.potential_coordinates([5, 7])).to eq([[5, 6],[5, 5]])
        end
    end

    context 'When green pawn is at square [7,5] and green pawn is at [6,4] and [8,4]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:blue)
            pawn2 = Pawn.new(:green)
            setup.deploy(pawn1,[[7, 5]])
            setup.deploy(pawn2,[[6, 4], [8, 4]])
            allow(board).to receive(:turn) {:blue}
            expect(board.potential_coordinates([7,5])).to eq([[7,4], [6, 4],[8, 4]])
        end
    end

    context 'When green pawn is at square [5, 6] and blue pawn is at [8,8]' do
        it 'will give an array of squares it can go to' do
            pawn1 = Pawn.new(:blue)
            pawn2 = Pawn.new(:green)
            setup.deploy(pawn1,[[5, 6]])
            setup.deploy(pawn2,[[8, 8]])
            expect(board.potential_coordinates([5,6])).to eq([[5,5]])
        end
    end
end

