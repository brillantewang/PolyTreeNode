require '../polytreenode/lib/00_tree_node.rb'

class KnightPathFinder
  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @grid = Array.new(8) { Array.new(8) }

    build_move_tree
  end

  def populate_nodes
    @grid.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        pos = [row_idx, col_idx]
        self[pos] = PolyTreeNode.new(pos)
      end
    end
  end

  def build_move_tree
    queue = []


  end

  def self.valid_moves(pos)
  end

  def new_move_positions(pos)
    self.class.valid_moves - @visited_positions
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def in_range?(pos)
    pos.all? { |n| n.between?(0, @grid.size - 1) }
  end

end
