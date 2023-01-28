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
        when 'q'
        exit
        end
    end              
end