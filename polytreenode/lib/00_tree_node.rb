require 'byebug'

class PolyTreeNode
  attr_reader :parent, :value
  attr_accessor :children

  def initialize(value)
    @value, @parent, @children = value, nil, []
  end

  def children
    @children.dup
  end

  def parent=(parent_node)
    return if self.parent == parent_node

    if @parent
      @parent._children.delete(self)
    end

    @parent = parent_node
    @parent._children << self unless @parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Child does not have parent =(" if child_node.parent.nil?
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      search_result = child.dfs(target_value)
      return search_result if search_result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      curr_node = queue.shift
      return curr_node if curr_node.value == target_value
      queue += curr_node.children
    end

    nil
  end

  protected

  def _children
    @children
  end
end

if __FILE__ == $PROGRAM_NAME
  node1 = PolyTreeNode.new('root')
  node2 = PolyTreeNode.new('child1')
  node3 = PolyTreeNode.new('child2')

  node2.parent = node1
end
