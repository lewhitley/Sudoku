require_relative  "tile.rb"
require "colorize"

class Board
  def initialize(filename)
    @grid = number_to_tile(filename)
  end

  def number_to_tile(filename)
    rows = []
    File.readlines(filename).each do |line|
      rows.push(line.chomp)
    end
    string_to_array(rows)
  end

  def string_to_array(rows)
    tiles = []
    rows.each_with_index do |row, i|
      row_array(row,i,tiles)
    end
    tiles
  end

  def row_array(row,i,tiles)
    tile_row = []
    row.each_char.with_index do |elem,j|
      tile_row << Tile.new(elem.to_i,[i,j])
    end
    tiles << tile_row
  end

  def position(value, pos)
    @grid[pos[0]][pos[1]].set_value(value)
  end

  def render
    render_arr = []
    @grid.each do |row|
      render_row = []
      row.each do |tile|
        render_row << tile.change_color
      end
      render_arr << render_row.join("  ")
    end
    puts render_arr
  end

  def solved?
    all_sections = rows + columns + squares
    all_sections.all? {|section| section_solved?(section)}
  end

  def rows
    @grid
  end

  def columns
    @grid.transpose
  end

  def squares
    square = []
    [0,3,6].each do |i|
      [0,3,6].each do |j|
        square << @grid[i..i+2].map{|row| row[j..j+2]}.flatten
      end
    end
    square
  end

  def section_solved?(section)
    count_hash = Hash[(1..9).map{|key| [key, 0]}]
    section_values(section).each do |number|
      count_hash[number] += 1 if count_hash[number]
    end
    count_hash.values.all?{|value| value == 1}
  end

  def section_values(section)
    section.map do |tile|
      tile.value
    end
  end
end
