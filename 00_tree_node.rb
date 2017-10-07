require 'byebug'

class PolyTreeNode
  attr_reader :parent, :value
  attr_accessor :children

  def initialize(value)
    @value, @parent, @children = value, nil, []
  end

  def parent=(parent_node)
    if !@parent.nil?
      parent.children.delete(self)
    end

    if parent_node.nil?
      @parent = nil
    else
      @parent = parent_node
      unless parent_node.children.include?(self)
        parent_node.children << self
      end
    end
  end

  def add_child(child_node)
    @children << child_node unless children.include?(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Child does not have parent =(" if child_node.parent.nil?
    children.delete(child_node)
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
  end
end

if __FILE__ == $PROGRAM_NAME
  node1 = PolyTreeNode.new('root')
  node2 = PolyTreeNode.new('child1')
  node3 = PolyTreeNode.new('child2')

  node2.parent = node1
end
