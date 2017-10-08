require '../polytreenode/lib/00_tree_node.rb'

class KnightPathFinder
  MOVES = [
    [-2, 1],
    [-1, 2],
    [1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2],
    [-2, -1]
  ]

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]

    build_move_tree
  end

  def find_path(end_pos)
    end_node = @root_node.dfs(end_pos)

    trace_path_back(end_node).reverse.map(&:value)
  end

  def trace_path_back(end_node)
    path = []

    curr_node = end_node
    until curr_node.nil?
      path << curr_node
      curr_node = curr_node.parent
    end

    path
  end

  def build_move_tree
    @root_node = PolyTreeNode.new(@start_pos)
    queue = [@root_node]

    until queue.empty?
      curr_node = queue.shift
      curr_pos = curr_node.value

      new_move_positions(curr_pos).each do |new_pos|
        new_node = PolyTreeNode.new(new_pos)
        curr_node.add_child(new_node)
        queue << new_node
      end
    end
  end

  def self.valid_moves(pos)
    # debugger
    moves = []
    curr_x, curr_y = pos

    MOVES.each do |(shift_x, shift_y)|
      new_pos = [curr_x + shift_x, curr_y + shift_y]
      moves << new_pos if in_range?(new_pos)
    end

    moves
  end

  def new_move_positions(pos)
    new_moves = self.class.valid_moves(pos) - @visited_positions
    @visited_positions += new_moves
    new_moves
  end

  def self.in_range?(pos)
    pos.all? { |n| n.between?(0, 7) }
  end
end
