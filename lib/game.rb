require_relative 'board'
require_relative 'tetromino'
require 'colorize'
require 'debugger'

class Game
  attr_accessor :board
  
  def initialize
    @board = Board.new
    @pieces = { "I" => [[[ 0, 0], [ 0, 1], [ 0, 2], [ 0, 3]], 
                        [[ 0, 0], [-1, 0], [-2, 0], [-3, 0]]],
      
                "J" =>  [[[-1,  0], [-1, 1], [-1, 2], [ 0, 2]],
                         [[ 0,  0], [ 0, 1], [-1, 1], [-2, 1]],
                         [[-1,  0], [ 0, 0], [ 0, 1], [ 0, 2]],
                         [[ 0 , 0], [-1, 0], [-2, 0], [-2, 1]]],
                                          
                "L" => [[[-1, 0], [-1, 1], [-1, 2], [ 0, 0]],
                        [[-2, 0], [-1, 0], [ 0, 0], [ 0, 1]],
                        [[ 0, 0], [ 0, 1], [ 0, 2], [-1, 2]],
                        [[ 0, 1], [-1, 1], [-2, 1], [-2, 0]]],
                        
                "O" => [[[-1, 0], [-1, 1], [ 0, 0], [ 0, 1]]],
                        
                "S" => [[[ 0, 0], [ 0, 1], [-1, 1], [-1, 2]],
                        [[ 0, 1], [-1, 1], [-1, 0], [-2, 0]]],
                        
                "T" => [[[-1, 0], [-1, 1], [-1, 2], [ 0, 1]],
                        [[ 0, 0], [-1, 0], [-2, 0], [-1, 1]],
                        [[-1, 0], [-2, 1], [-1, 1], [ 0, 1]],
                        [[ 0, 0], [ 0, 1], [ 0, 2], [-1, 1]]],
                                 
                "Z" => [[[-1, 0], [-1, 1], [ 0, 1], [ 0, 2]],
                        [[ 0, 0], [-1, 0], [-1, 1], [-2, 1]]] }
              
  end
  
  def play
    puts "Do you want me to make a move? (y/n): "
    while gets.chomp == 'y'
      return if make_move == false
      puts "Do you want me to make another move? (y/n): "
    end
  end
  
  
  def make_move
    return false if spawn_new_tetromino == false
    print
    @board.check_for_full_rows
  end
  
  def print
    @board.print
  end
  
  private
  
  def spawn_new_tetromino
    shape = @pieces.keys.sample
    Tetromino.new(@board, @pieces[shape], shape).find_best_position
  end
end


if __FILE__ == $PROGRAM_NAME
  Game.new.play
end