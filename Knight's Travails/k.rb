require_relative 'tree stuff'
require 'byebug'

class KnightPathFinder
  DELTAS = [
     [1, 2],
     [2, 1],
     [-1, 2],
     [-2, 1],
     [1, -2],
     [2, -1],
     [-1, -2],
     [-2, -1]
   ]

   attr_reader :move_tree, :visited_positions, :root

  def initialize(pos)
    @starting_position = pos
    @root = PolyTreeNode.new(pos)
    @visited_positions = [@starting_position]
    build_move_tree
  end

  def build_move_tree

    queue = [@root]

    until queue.empty?

      current_node = queue.shift

      child_positions = []
      child_positions += new_move_positions(current_node.value)

      child_positions.each do |child_pos|
        child_node = PolyTreeNode.new(child_pos)
        child_node.parent = current_node
        queue << child_node
      end
    end
  end


  def self.valid_moves(pos)
    row = pos[0]
    col = pos[1]

    potential_moves = DELTAS.map { |dx, dy| [row + dx, col + dy] }

    potential_moves.select do |pos|
      pos.all? { |cord| cord.between?(0, 7) }
    end
    # QUESTION: why do we need to return potential_moves after using the
    # dangerous version of select?
    # potential_moves
  end


  def new_move_positions(pos)
    new_pos = KnightPathFinder.valid_moves(pos).reject { |pos| @visited_positions.include?(pos)}
    @visited_positions += new_pos
    new_pos
  end

  def find_path(end_pos)
    node_path = trace_path(end_pos)
    node_path.map { |node| node.value }
  end

  def trace_path(end_pos)
    node_path = []
    current_node = @root.bfs(end_pos)

    until current_node == root
      node_path << current_node
      current_node = current_node.parent
    end
    node_path << root
    node_path.reverse
  end

end

n = KnightPathFinder.new([0,0])
p n.find_path([6,2])
