require 'io/console'

class Human

    attr_reader :board

    def initialize(board)
        @board = board
    end

    def move  
        keypress = STDIN.getch.downcase
        case keypress
        when 'w'
        board.update_cursor([0,1]) 
        when 's'
        board.update_cursor([0,-1]) 
        when 'a'
        board.update_cursor([-1,0])
        when 'd'
        board.update_cursor([1,0])
        when "\r"
            current_piece = board.grid[board.cursor]
            if( current_piece != nil && current_piece.color == board.turn )
                board.display.decolorize_hints
                board.fill_hints
                board.display.colorize_hints
            else
                board.transport_piece
                board.reset_hints
                board.display.decolorize_hints
            end
        when 'q'
        exit
        end     
    end         
end