require 'colorize'
require 'tty-cursor'

class Display

  attr_reader :board, :squares

  def initialize(board)
    @board = board
    @squares = {}
    make_squares
  end

  def render_board
    system("clear")
    restore_background
    emphasize_cursor
    8.downto(1).each do |rank|
      1.upto(8).each do |file|
        print squares[[file, rank]]
      end
      puts "\n"
    end
    print "\n\n\n\n"
    board.save_cursor
  end

  def decolorize_hints
    board.squares_to_highlight.each do |coordinate|
      squares[coordinate] = fill_background(squares[coordinate],
      background_color(coordinate))
    end
  end

  def colorize_hints
    board.squares_to_highlight.each do |coordinate|
      squares[coordinate] = fill_background(squares[coordinate],
                                            :magenta)
    end
  end

  def transport_piece
    piece = board.grid[board.selected_square]
    current_cursor = board.cursor
    selected_square = board.selected_square
    squares[current_cursor] = piece.image.colorize(piece.color).
      colorize(:background=>background_color(current_cursor))
    squares[selected_square] = fill_background('  ',
    background_color(selected_square))
  end

  def mount_pieces
    board.grid.each do |coordinate, value|
     if value 
        squares[coordinate] = value.image.colorize(value.color).
          colorize(:background=>background_color(coordinate))
      end
    end
  end

  private

  def make_squares
    board.grid.keys.each do |coordinate|
      squares[coordinate] = fill_background('  ',
      background_color(coordinate))
    end
  end

  def restore_background
    previous_cursor = board.previous_cursor
    squares[previous_cursor] = fill_background(squares[previous_cursor],
    background_color(previous_cursor))
    squares[previous_cursor] = fill_background(squares[previous_cursor],
    :magenta) if board.squares_to_highlight.include?(previous_cursor)
  end

  def emphasize_cursor
    cursor = board.cursor
    squares[cursor] = fill_background(squares[cursor], :red)
  end

  def fill_background(container, color)
    container.colorize(:background=>color)
  end

  def background_color(coordinate)
    if (coordinate.first + coordinate.last).even?
      :yellow
    else
      :cyan
    end
  end
end
