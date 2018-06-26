class DagDepthTopoSort
  attr_writer :starting_point

  def initialize
    @traversal = DfsTraversal.new
  end

  def graph=(graph)
    @graph = graph
    @depth = {}
  end

  def topo_sort
    ordered_vertices = traverse
    # puts "#{ordered_vertices}"
    puts @graph
    depth = {}
    ordered_vertices.each do |vertex|
      depth[vertex] = 
        @graph[vertex].map do |neighbor| 
          depth[neighbor]
        end.max + 1 unless @graph[vertex].length.zero?
      depth[vertex] = 1 if @graph[vertex].length.zero?
    end
    format depth
  end

  def traverse
    graph_topo_sorted = @traversal.traverse(@graph, @starting_point)
  end

  private

  def format(depth)
    depth.map do |key, value|
      {
        vertex: key,
        priority: value
      }
    end
  end
end