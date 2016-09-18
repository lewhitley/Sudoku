require "colorize"

class Tile
  def initialize(value, pos)
    @value = value
    @pos = pos
    @color = colorize_tile
  end

  attr_reader :value, :pos, :color

  def colorize_tile
    if @value == 0
      :blue
    else
      :red
    end
  end

  def set_value(value)
    @value = value
  end

  def change_color
    @value.to_s.colorize(@color)
  end
end
