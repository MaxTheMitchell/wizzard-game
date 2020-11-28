class Grid
  def initialize(options = {})
    @list = options[:list]
  end

  def find_fatest_path(start_pos, end_pos)
    depth_first_search([start_pos], end_pos)
  end

  private


  def depth_first_search(visited_nodes, end_pos)
    return visited_nodes if visited_nodes[-1] == end_pos
    adjacent_nodes(visited_nodes[-1]).filter do |node|
      @list[node[0]][node[1]] and (not visited_nodes.include?(node))
    end.map do |node|
      depth_first_search((visited_nodes.dup << node), end_pos)
    end.filter { |path| path != nil }.min_by { |path| path.length }
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
