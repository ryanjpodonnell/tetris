require_relative 'board'
require_relative 'tetromino'

class Game
  attr_accessor :board
  
  def initialize
    @board = Board.new
  end
  
  def play
    puts "Do you want me to make a move? (y/n): "
    while gets.chomp == 'y'
      make_move
      puts "Do you want me to make another move? (y/n): "
    end
  end
  
  def make_move
    spawn_new_tetromino
    print
    @board.check_for_full_rows
  end
  
  def print
    @board.print
  end
  
  private
  
  def spawn_new_tetromino
    Tetromino.new(@board).find_best_position
  end
end


if __FILE__ == $PROGRAM_NAME
  Game.new.play
end