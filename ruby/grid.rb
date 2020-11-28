class Grid
  def initialize(options = {})
    @list = options[:list]
  end

  def find_fatest_path(start_pos, end_pos)
    # depth_first_search([start_pos], end_pos)
    a_star([start_pos], end_pos)
  end

  private

  def a_star(visited_nodes, end_pos)
    return visited_nodes if visited_nodes[-1] == end_pos
    a_star(
      visited_nodes << neighbour_nodes(visited_nodes[-1])
        .filter { |node| not visited_nodes.include?(node) }
        .min_by { |node| daigonal_h(node, end_pos) },
      end_pos
    )
  end

  def f(visited_nodes, current_node, end_pos)
    g(visited_nodes) + daigonal_h(visited_nodes[0], end_pos)
  end

  def daigonal_h(start_pos, end_pos)
    [
      (start_pos[0] - end_pos[0]).abs,
      (start_pos[1] - end_pos[1]).abs,
    ].max
  end

  def depth_first_search(visited_nodes, end_pos)
    return visited_nodes if visited_nodes[-1] == end_pos
    adjacent_nodes(visited_nodes[-1]).filter do |node|
      @list[node[0]][node[1]] and (not visited_nodes.include?(node))
    end.map do |node|
      depth_first_search((visited_nodes.dup << node), end_pos)
    end.filter { |path| path != nil }.min_by { |path| path.length }
  end

  def neighbour_nodes(node)
    adjacent_nodes(node).filter { |node| @list[node[0]][node[1]] }
  end

  def adjacent_nodes(node)
    nodes = []
    ((node[0] - 1)..(node[0] + 1)).each do |x|
      ((node[1] - 1)..(node[1] + 1)).each do |y|
        if x >= 0 and x < width and y >= 0 and y < hieght
          nodes << [x, y]
        end
      end
    end
    nodes
  end

  def width() @list.length end
  def hieght() @list[0].length end
end
