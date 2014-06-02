class Tetromino
  attr_reader :shape
  
  def initialize(board, shape)
    @board = board
    @shape = shape
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
      (0...20).each do |row|
        # row = find_lowest_open_tile(col)
        all_positions.push([row, col]) if tetromino_fits?([row, col])
      end
    end
    all_positions
  end
  
  def find_lowest_open_tile(col)
    (0...20).to_a.each do |row|
      next if @board.empty?([row, col])
      return row - 1
    end
    @board.num_rows - 1
  end
  
  def tetromino_fits?(pos)
    @shape.all? do |seg_pos|
      x = seg_pos[0] + pos[0]
      y = seg_pos[1] + pos[1]
      @board.empty?([x, y]) && Board.valid_pos?([x, y])
    end
  end
end