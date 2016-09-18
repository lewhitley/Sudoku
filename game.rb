require_relative "tile.rb"
require_relative "board.rb"

class Game
  def initialize(filename)

    @board = Board.new(filename)
  end

  def play
    until @board.solved?
      @board.render
      pos_prompt
      pos = gets.chomp.split(",").map(&:to_i)
      value_prompt
      value = gets.chomp.to_i
      handle_move(value,pos)
    end
    puts "game solved"
    @board.render
  end

  def pos_prompt
    puts "please enter a position i.e. 2,3"
  end

  def value_prompt
    puts "please enter a value for this postion"
  end

  def handle_move(value,pos)
    @board.position(value,pos)
  end
end
