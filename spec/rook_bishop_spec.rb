require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/bishop'
require_relative '../lib/board'
require_relative '../lib/setup'
require_relative '../lib/coordinates_finder'



describe Rook do
  let(:board) { Board.new }
  let(:setup) { Setup.new(board) }

  context 'When rook is at square [1,1]' do
    it 'will give an array of squares it can go to' do
      rook = Rook.new(:green)
      setup.deploy(rook, [[1, 1]])
      expect(board.potential_coordinates([1, 1])).to eq([[2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1], [8, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8]])
    end
  end

  context 'When rook is at square [5,6]' do
    it 'will give an array of squares it can go to' do
      rook = Rook.new(:green)
      setup.deploy(rook, [[5, 6]])
      expect(board.potential_coordinates([5, 6])).to eq([[6, 6], [7, 6], [8, 6], [5, 5], [5, 4], [5, 3], [5, 2], [5, 1], [4, 6], [3, 6], [2, 6], [1, 6], [5, 7], [5, 8]])
    end
  end

  context 'When rook is at square [5,6] and a same side rook obstructs the path by three sides' do
    it 'will give an array of squares it can go to' do
      rook = Rook.new(:green)
      setup.deploy(rook, [[5, 6], [5, 7], [5, 5], [4, 6]])
      expect(board.potential_coordinates([5, 6])).to eq([[6, 6], [7, 6], [8, 6]])
    end
  end

  context 'When rook is at square 0 and a same side rook obstructs the path and opp side rook obstructs path at [6,6]' do
    it 'will give an array of squares it can go to' do
      rook1 = Rook.new(:green)
      rook2 = Rook.new(:black)
      setup.deploy(rook1, [[5, 6], [5, 7], [5, 5], [4, 6]])
      setup.deploy(rook2, [[6, 6]])
      expect(board.potential_coordinates([5, 6])).to eq([[6, 6]])
    end
  end
end

describe Bishop do
  let(:board) { Board.new }
  let(:setup) { Setup.new(board) }

  context 'When bishop is at square [1,1]' do
    it 'will give an array of squares it can go to' do
      bishop = Bishop.new(:green)
      setup.deploy(bishop, [[1, 1]])
      expect(board.potential_coordinates([1, 1])).to eq([[2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [8, 8]])
    end
  end

  context 'When bishop is at square [5,6]' do
    it 'will give an array of squares it can go to' do
      bishop = Bishop.new(:green)
      setup.deploy(bishop, [[5, 6]])
      expect(board.potential_coordinates([5, 6])).to eq([[6, 7], [7, 8], [4, 7], [3, 8], [4, 5], [3, 4], [2, 3], [1, 2], [6, 5], [7, 4], [8, 3]])
    end
  end

  context 'When bishop is at square [5,6] and a same side bishop obstructs the path by three sides' do
    it 'will give an array of squares it can go to' do
      bishop = Bishop.new(:green)
      setup.deploy(bishop, [[5, 6], [6, 7], [4, 7], [4, 5]])
      expect(board.potential_coordinates([5, 6])).to eq([[6, 5], [7, 4], [8, 3]])
    end
  end

  context 'When bishop is at square [5,6] and a same side bishop obstructs the path and opp side bishop obstructs path at [6,7]' do
    it 'will give an array of squares it can go to' do
      rook1 = Bishop.new(:green)
      rook2 = Bishop.new(:black)
      setup.deploy(rook1, [[5, 6], [4, 7], [4, 5], [6, 5]])
      setup.deploy(rook2, [[6, 7]])
      expect(board.potential_coordinates([5, 6])).to eq([[6, 7]])
    end
  end
end