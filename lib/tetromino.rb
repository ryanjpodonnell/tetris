class Tetromino
  attr_reader :shape
  
  def initialize(board)
    @board = board
    @shape = [[-1, 0], [-1, 1], 
              [ 0, 0], [ 0, 1]]
  end  
  
  def find_best_position
    all_positions  = find_all_positions
    
    best_row       = all_positions.collect { |idx| idx[0] }.max
    best_positions = all_positions.select { |pos| pos.first == best_row }
    best_col       = best_positions.collect { |idx| idx[1] }.min
    
    @shape.each do |segment|
      @board[[segment[0] + best_row, segment[1] + best_col]] = true
    end
    
    [best_row, best_col]
  end
  
  private
  
  def find_all_positions
    all_positions = []
    (0...10).each do |col|
      row = find_lowest_open_tile(col)
      all_positions.push([row, col]) if tetromino_fits?([row, col])
    end
    all_positions
  end
  
  def find_lowest_open_tile(col)
    (0...20).to_a.reverse.each do |row|
      return row if @board.empty?([row, col])
    end
    nil
  end
  
  def tetromino_fits?(pos)
    @shape.all? do |seg_pos|
      x = seg_pos[0] + pos[0]
      y = seg_pos[1] + pos[1]
      @board.empty?([x, y]) && Board.valid_pos?([x, y])
    end
  end
end