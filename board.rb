require_relative 'tetromino'

class Board
  def initialize
    @grid = Array.new(20) { Array.new(10, nil) }
  end
  
  def print
    puts self.render
  end
  
  def render
    @grid.map do |row|
      row.map do |tile|
        "*"
      end.join("")
    end.join("\n")
  end
end