
require_relative '../lib/board'
require_relative '../lib/setup'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/king'

describe Board do
  context 'king side castling' do
    let(:board) { Board.new }
    let(:setup) { Setup.new(board) }

   it 'changes the position of king and rook since no opponent pieces X-rays
	between king and rook and king is not in check' do

      king = King.new(:green)
      rook = Rook.new(:green)
      
      setup.deploy(king, [[5,1]])
      setup.deploy(rook, [[8,1]])
      
      board.castle_kingside
      expect( board.grid[[7,1]] ).to equal(king)
      expect( board.grid[[6,1]] ).to equal(rook)
      
    end

   it 'is unable to castle as a piece is present in between' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    queen = Queen.new(:green)
    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[8,1]])
    setup.deploy(queen, [[6,1]])

    board.castle_kingside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[8,1]] ).to equal(rook)
   end

   it 'is unable to castle as opponent queen has checked the king' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_queen = Queen.new(:blue)

    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[8,1]])
    setup.deploy(opponent_queen, [[8,4]])

    board.castle_kingside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[8,1]] ).to equal(rook)

   end

   it 'is unable to castle as opponent queen xrays between king and queen' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_queen = Queen.new(:blue)

    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[8,1]])
    setup.deploy(opponent_queen, [[7,8]])

    board.castle_kingside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[8,1]] ).to equal(rook)

   end

   it 'is unable to castle as opponent pawn xrays between king and queen' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_pawn = Pawn.new(:blue)

    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[8,1]])
    setup.deploy(opponent_pawn, [[7,2]])

    board.castle_kingside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[8,1]] ).to equal(rook)

   end

   it 'is unable to castle as king has already moved' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[8,1]])
    board.castle.break([5,1])

    board.castle_kingside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[8,1]] ).to equal(rook)

   end

   it 'is unable to castle as king side rook has already moved' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[8,1]])
    board.castle.break([8,1])

    board.castle_kingside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[8,1]] ).to equal(rook)

   end
  end

  context 'queen side castling' do
    let(:board) { Board.new }
    let(:setup) { Setup.new(board) }

   it 'changes the position of king and rook since no opponent pieces X-rays
	between king and rook and king is not in check' do

      king = King.new(:green)
      rook = Rook.new(:green)
      
      setup.deploy(king, [[5,1]])
      setup.deploy(rook, [[1,1]])
      
      board.castle_queenside

      expect( board.grid[[3,1]] ).to equal(king)
      expect( board.grid[[4,1]] ).to equal(rook)
      
    end

   it 'is unable to castle as a piece is present in between' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    queen = Queen.new(:green)
    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[1,1]])
    setup.deploy(queen, [[2,1]])

    board.castle_queenside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[1,1]] ).to equal(rook)
   end

   it 'is unable to castle as opponent queen has checked the king' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_queen = Queen.new(:blue)

    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[1,1]])
    setup.deploy(opponent_queen, [[5,4]])

    board.castle_queenside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[1,1]] ).to equal(rook)

   end

   it 'is able to castle even if opponent queen xrays 2nd file' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_queen = Queen.new(:blue)

    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[1,1]])
    setup.deploy(opponent_queen, [[2,5]])
    
    board.castle_queenside

    expect( board.grid[[3,1]] ).to equal(king)
    expect( board.grid[[4,1]] ).to equal(rook)
   end

   it 'is unable to castle as opponent queen xrays between king and queen' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_queen = Queen.new(:blue)

    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[1,1]])
    setup.deploy(opponent_queen, [[3,8]])

    board.castle_queenside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[1,1]] ).to equal(rook)

   end

   it 'is unable to castle as opponent pawn xrays between king and queen' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_pawn = Pawn.new(:blue)

    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[1,1]])
    setup.deploy(opponent_pawn, [[4,2]])

    board.castle_queenside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[1,1]] ).to equal(rook)

   end

   it 'is unable to castle as king has already moved' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[1,1]])

    board.castle.break([5,1])

    board.castle_queenside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[1,1]] ).to equal(rook)

   end

   it 'is unable to castle as king side rook has already moved' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    setup.deploy(king, [[5,1]])
    setup.deploy(rook, [[1,1]])
    board.castle.break([1,1])
    
    board.castle_queenside

    expect( board.grid[[5,1]] ).to equal(king)
    expect( board.grid[[1,1]] ).to equal(rook)

   end
  end

end
