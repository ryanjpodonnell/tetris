class Tetromino
  attr_reader :geometry, :shape
  
  def initialize(board, geometry, shape)
    @board = board
    @geometry = geometry
    @shape = shape
  end  
  
  def find_best_position
    all_positions  = find_all_positions
    
    all_positions.each do |pos|
      place_piece(@geometry[pos["idx"]], [pos["row"], pos["col"]])
      count_tiles(pos)
      remove_piece(@geometry[pos["idx"]], [pos["row"], pos["col"]])
    end
    
    all_positions.select!{|pos| pos["num_tiles"] == find_lowest(all_positions, "num_tiles")}
    all_positions.select!{|pos| pos["row"] == find_highest(all_positions, "row")}
    all_positions.select!{|pos| pos["col"] == find_lowest(all_positions, "col")}
    
    return false if all_positions.empty?
    
    best_move = all_positions.first
    place_piece(@geometry[best_move["idx"]], [best_move["row"], best_move["col"]])
    
    true
  end
  
  private
  
  def find_all_positions
    all_positions = []
    @geometry.each_with_index do |shape, idx|
      (0...10).each do |col|
        (0...20).each do |row|
          # row = find_lowest_open_tile(col)
          if tetromino_fits?([row, col], idx)
            all_positions.push({"row" => row, "col" => col, "idx" => idx}) 
          end
        end
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
  
  def tetromino_fits?(pos, idx)
    @geometry[idx].all? do |seg_pos|
      x = seg_pos[0] + pos[0]
      y = seg_pos[1] + pos[1]
      Board.valid_pos?([x, y]) && @board.empty?([x, y])
    end
  end
  
  def place_piece(geometry, origin)
    geometry.each do |segment|
      @board[[segment[0] + origin[0], segment[1] + origin[1]]] = @shape
    end
  end
  
  def remove_piece(geometry, origin)
    geometry.each do |segment|
      @board[[segment[0] + origin[0], segment[1] + origin[1]]] = nil
    end
  end
  
  def count_tiles(pos)
    num_tiles = 0
    (0...10).each do |col|
      (0...20).each do |row|
        if !@board[[row, col]].nil?
          num_tiles += (@board.num_rows - row)
          break
        end
      end
    end
    pos["num_tiles"] = num_tiles
  end
  
  def find_lowest(positions, key)
    lowest = positions.first[key]
    positions.each do |pos|
      lowest = pos[key] if pos[key] < lowest
    end
    lowest
  end
  
  def find_highest(positions, key)
    highest = positions.first[key]
    positions.each do |pos|
      highest = pos[key] if pos[key] > highest
    end
    highest
  end
end