class Board
  attr_reader :grid

  SPACES = 9
  ROWS = [[0, 1, 2], [3, 4, 5], [6, 7, 8]].freeze
  COLUMNS = [[0, 3, 6], [1, 4, 7], [2, 5, 8]].freeze
  DIAGONALS = [[0, 4, 8], [2, 4, 6]].freeze

  def initialize
    @grid = create
  end

  def print
    puts "|#{@grid[0]}|" + "#{@grid[1]}|" + "#{@grid[2]}|"
    puts "|#{@grid[3]}|" + "#{@grid[4]}|" + "#{@grid[5]}|"
    puts "|#{@grid[6]}|" + "#{@grid[7]}|" + "#{@grid[8]}|"
  end

  def space_exist?(space)
    space >= SPACES - SPACES && space < SPACES
  end

  def space_is_free?(space)
    space_exist?(space) && grid[space] == '-'
  end

  def winning_move?
    win?(ROWS) || win?(COLUMNS) || win?(DIAGONALS)
  end

  def drawing_move?
    !winning_move? && !grid.include?('-')
  end

  private

  def create(n = SPACES, val = '-')
    Array.new(n, val)
  end

  def win?(type)
    three_possible_solutions?(type) ? row_or_column_win?(type) : diagonal_win?(type)
  end

  def row_or_column_win?(type)
    symbols_are_equal?(type[0]) || symbols_are_equal?(type[1]) || symbols_are_equal?(type[2])
  end

  def diagonal_win?(type)
    symbols_are_equal?(type[0]) || symbols_are_equal?(type[1])
  end

  def three_possible_solutions?(type)
    type.length == 3
  end

  def symbols_are_equal?(array)
    grid_array = transform_to_spaces(array)
    grid_array.uniq.length == 1 && grid_array[0] != '-'
  end

  def transform_to_spaces(array)
    array.map { |e| grid[e] }
  end
end
