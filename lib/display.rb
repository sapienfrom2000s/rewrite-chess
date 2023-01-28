require 'colorize'
require 'tty-cursor'

class Display

    attr_reader :board, :squares

    def initialize(board)
        @board = board
        @squares = {}
        make_squares
        mount_pieces
    end

    def render_board
        restore_background
        emphasize_background
        8.downto(1).each do |rank|
            1.upto(8).each do |file|
                print squares[[file,rank]]
            end
            print "\n"
        end
        print "\n\n\n\n"
        board.save_cursor
    end

    private

    def make_squares
        board.grid.keys.each do |coordinate|
            @squares[coordinate] = fill_background('  ',background_color(coordinate))
        end
    end

    def restore_background
        previous_cursor = board.previous_cursor
        @squares[previous_cursor] = fill_background(squares[previous_cursor],background_color(previous_cursor))
    end

    def emphasize_background
        cursor = board.cursor
        squares[cursor] = squares[cursor].colorize(:background=>:red)
    end

    def fill_background(container,color)
        container.colorize(:background=>color)
    end

    def background_color(coordinate)
        if (coordinate.first + coordinate.last).even?
            :yellow
        else
            :cyan
        end
    end

    def mount_pieces
        board.grid.each do |coordinate, value|
            unless value.nil? 
                squares[coordinate] = value.image.colorize(value.color).colorize(:background=>background_color(coordinate))  
            end
        end
    end
end