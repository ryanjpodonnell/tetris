require_relative 'tetromino'

class Board  
  def initialize
    @grid = Array.new(20) { Array.new(10, nil) }
  end
  
  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, segment)
    x, y = pos
    @grid[x][y] = segment
  end
  
  def empty?(pos)
    self[pos].nil?
  end
  
  def print
    puts self.render
  end
  
  def render
    @grid.map do |row|
      row.map do |tile|
        tile.nil? ? "." : "#"
      end.join("")
    end.join("\n")
  end
  
  def self.valid_pos?(pos)
    x, y = pos
    x.between?(0, 19) && y.between?(0, 9)
  end
  
  def check_for_full_rows
    @grid.each_with_index do |row, idx|
      delete_row(idx) if row.all? {|tile| !tile.nil? }
    end
  end
  
  def num_rows
    20
  end
  
  private
  
  def delete_row(idx)
    @grid.delete_at(idx)
    @grid.unshift(Array.new(10, nil))
  end
end