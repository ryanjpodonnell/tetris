require_relative 'board'
require_relative 'tetromino'

class Game
  def initialize
    @board = Board.new
  end
  
  def play
    
  end
  
  def print
    @board.print
  end
end