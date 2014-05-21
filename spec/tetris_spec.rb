require 'rspec'
require 'game'

describe Game do
  let(:game) {Game.new}

  describe "Playing A Game" do
    context "making a move" do
      before(:each) do 
        game.make_move
      end
      
      it "should have placed a square on the bottom-left" do
        expect(game.board.empty?([19, 0])).to be_false
      end
      
      it "should place a second square to the right of the first" do
        game.make_move
        expect(game.board.empty?([19, 2])).to be_false
      end
    end
    
    context "clearing a row (or 2)" do
      before(:each) do 
        game.make_move
        game.make_move
        game.make_move
        game.make_move
        game.make_move
      end
      
      it "should clear both full rows" do
        expect(game.board.empty?([19, 0])).to be_true
      end
    end
  end
end


describe Board do
  let(:board) {Board.new}

  describe "Altering The Board" do
    context "indexing and assigning the grid" do
      before(:each) do 
        board[[19, 0]] = true
      end
      
      it "should have assigned the bottom-left tile" do
        expect(board.empty?([19, 0])).to be_false
      end
      
      it "should be able to index the bottom-left tile" do
        expect(board[[19, 0]]).to eq(true)
      end
      
      it "should be able to check if a tile is empty" do
        expect(board.empty?([17, 0])).to eq(true)
      end
    end
    
    context "checking for valid grid positions" do  
      it "should say [20, 0] is not inside the grid" do
        expect(Board.valid_pos?([20, 0])).to be_false
      end
      
      it "should say [19, 0] is inside the grid" do
        expect(Board.valid_pos?([19, 0])).to be_true
      end
    end
  end
end


describe Tetromino do
  subject(:tetromino) {Tetromino.new(Board.new)}
  
  its (:shape) { should == [[-1, 0], [-1, 1], [ 0, 0], [ 0, 1]] }

  describe "Determining Where to Move" do
    context "finding the best position" do
      before(:each) do 
      end
      
      it "should find one move (best row and best column)" do
        expect(tetromino.find_best_position.count).to eq(2)
      end
    end
  end
end