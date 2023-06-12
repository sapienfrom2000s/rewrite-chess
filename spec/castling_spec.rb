
require_relative '../lib/board'
require_relative '../lib/setup'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/king'

describe Board do
  before do
    board = Board.new
    setup = Setup.new(board)
  end
  context 'king side castling' do
   it 'changes the position of king and rook since no opponent pieces X-rays\
	between king and rook and king is not in check' do
      king_green = King.new(:green)
      rook_green = Rook.new(:green)
      
      king_blue = King.new(:blue)
      rook_blue = Rook.new(:blue)
      setup.deploy(king_green, [[1,5]])
      setup.deploy(rook_green, [[1,8]])
      setup.deploy(rook_green, [[8,5]])
      setup.deploy(rook_green, [[8,8]])

      Specialmove.castle
      Specialmove.castle
      expect{ king_green.coordinate }.to eq([1,7])
      expect{ rook_green.coordinate }.to eq([1,6])
      
      expect{ king_blue.coordinate }.to eq([8,7])
      expect{ rook_blue.coordinate }.to eq([8,7])
   end

   it 'is unable to castle as a piece is present in between' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_queen = Queen.new(:blue)
    setup.deploy(king, [[1,5]])
    setup.deploy(rook, [[1,8]])
    setup.deploy(opponent_queen, [[1,6]])

    Specialmove.castle

    expect{ king.coordinate }.to eq([1,5])
    expect{ rook.coordinate }.to eq([1,8])
    
   end

   it 'is unable to castle as opponent queen X-rays between king and rook' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_queen = Queen.new(:blue)
    setup.deploy(king, [[1,5]])
    setup.deploy(rook, [[1,8]])
    setup.deploy(opponent_queen, [[5,6]])

    Specialmove.castle

    expect{ king.coordinate }.to eq([1,5])
    expect{ rook.coordinate }.to eq([1,8])
    
   end

   it 'is unable to castle as opponent pawn X-rays between king and rook' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_pawn = Pawn.new(:blue)
    setup.deploy(king, [[1,5]])
    setup.deploy(rook, [[1,8]])
    setup.deploy(opponent_pawn, [[2,7]])

    Specialmove.castle

    expect{ king.coordinate }.to eq([1,5])
    expect{ rook.coordinate }.to eq([1,8])
   end

   it 'is unable to castle as king is in check' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_pawn = Pawn.new(:blue)
    setup.deploy(king, [[1,5]])
    setup.deploy(rook, [[1,8]])
    setup.deploy(opponent_pawn, [[2,7]])

    Specialmove.castle

    expect{ king.coordinate }.to eq([1,5])
    expect{ rook.coordinate }.to eq([1,8])    
   end

   it 'is unable to castle as king has already moved earlier' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_pawn = Pawn.new(:blue)
    setup.deploy(king, [[1,5]])
    setup.deploy(rook, [[1,8]])
    setup.deploy(opponent_pawn, [[2,7]])
    king.move('somewhere')
    current_move = :green

    Specialmove.castle

    expect{ king.coordinate }.to eq([1,5])
    expect{ rook.coordinate }.to eq([1,8])    
   end

   it 'is unable to castle as rook has already moved' do
    king = King.new(:green)
    rook = Rook.new(:green)
    
    opponent_pawn = Pawn.new(:blue)
    setup.deploy(king, [[1,5]])
    setup.deploy(rook, [[1,8]])
    setup.deploy(opponent_pawn, [[2,7]])
    rook.move('somewhere')
    current_move = :green

    Specialmove.castle

    expect{ king.coordinate }.to eq([1,5])
    expect{ rook.coordinate }.to eq([1,8])
   end 
  end
end
