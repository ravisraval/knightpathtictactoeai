class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent #or @parent.dup?
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent_node)
    if @parent
      parent.children.delete(self)
    end
    @parent = parent_node
    parent_node.children << self unless parent_node == nil
  end

  def add_child(child_node)
    unless @children.include?(child_node)
      # @children.push(child_node) QUESTION: why not?
      child_node.parent = self
    end
  end

  def remove_child(child_node)
    raise 'not a child' unless @children.include?(child_node)
    @children.delete(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end

    nil
  end

  def bfs(target_value)
    # return self if self.value == target_value

    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end

    nil
  end

end
