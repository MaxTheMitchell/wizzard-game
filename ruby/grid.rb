class Grid
  def initialize(options = {})
    @nodes = positions_to_nodes(options[:positions])
  end

  def find_fatest_path(start_pos, end_pos)
    # puts @nodes.length
    staring_node = get_node_at_position(start_pos, @nodes)
    staring_node.g = 0
    staring_node.parent = nil
    a_star([staring_node], [], end_pos)
  end

  private

  def positions_to_nodes(positions)
    nodes = positions.map { |position| Node.new(position: position) }
    nodes.each do |node|
      node.adjacent_nodes = adjacent_positions(node.position)
        .map { |position| get_node_at_position(position, nodes) }
        .filter { |node| node != nil }
    end
    nodes
  end

  def a_star(open_list, closed_list, end_pos)
    current_node = open_list.min_by { |node| node.f(end_pos) }
    closed_list << open_list.delete(current_node)
    current_node.adjacent_nodes.each do |neighbor|
      if closed_list.include?(neighbor) and neighbor.g < current_node.g #faster way back to start
        current_node.g = neighbor.g + g_weight(current_node.position, neighbor.position)
        current_node.parent = neighbor
      elsif open_list.include?(neighbor) and neighbor.g > current_node.g
        neighbor.g = current_node.g + g_weight(current_node.position, neighbor.position)
        neighbor.parent = current_node
      elsif not(open_list.include?(neighbor) or closed_list.include?(neighbor))
        neighbor.g = current_node.g + g_weight(current_node.position, neighbor.position)
        open_list << neighbor
      end
    end
    return current_node.to_a if current_node.position == end_pos
    return [] if open_list == []
    a_star(open_list, closed_list, end_pos)
  end

  def adjacent_positions(position)
    positions = []
    ((position[0] - 1)..(position[0] + 1)).each do |x|
      ((position[1] - 1)..(position[1] + 1)).each do |y|
        positions << [x, y]
      end
    end
    positions
  end

  def get_node_at_position(position, nodes = @nodes)
    nodes.find { |node| node.position == position }
  end

  def g_weight(pos1,pos2)
    return 1.1 if daigonal?(pos1,pos2)
    1
  end

  def daigonal?(pos1,pos2)
    pos1[0] != pos2[0] and pos1[1] != pos2[1]
  end
end

class Node
  attr_accessor :parent, :g, :adjacent_nodes
  attr_reader :position

  def initialize(options = {})
    @adjacent_nodes = options[:adjacent_nodes] ||= []
    @position = options[:position]
    @parent = options[:parent] ||= nil
    @g = options[:g] ||= 0
  end

  def f(end_pos)
    g + daigonal_h(end_pos)
  end

  def to_a(positions = [])
    positions.unshift(@position)
    return @parent.to_a(positions) if has_parent?
    positions
  end

  private

  def has_parent?
    @parent != nil
  end

  def daigonal_h(end_pos)
    [
      (@position[0] - end_pos[0]).abs,
      (@position[1] - end_pos[1]).abs,
    ].max
  end
end
