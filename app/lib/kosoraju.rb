class Kosoraju
  WHITE = 0
  GRAY = 1
  BLACK = 2

  
  def initialize(graph)
    @traversal = DfsTraversal.new
    @graph = graph
    @transposed_graph = transpose graph
  end

  def get_cycles
    # @vertex_states = initialize_vertex_states
    topoSort = @graph.keys.map { |vertex| dfs(@graph, vertex) }.flatten.compact.reverse
    puts "Topo sort #{topoSort}"
    @traversal.reload
    cycles = topoSort.map do |vertex|
      cycle = []
      cycle = dfs(@transposed_graph, vertex)
      cycle if cycle.size > 1
    end.compact
  end

  private

  def initialize_vertex_states
    vertex_states = {}
    @graph.each do |vertex, neighbors|
      vertex_states[vertex] = WHITE
      neighbors.each do |neighbor|
        vertex_states[neighbor] = WHITE
      end
    end
    vertex_states
  end

  def transpose(graph)
    transposed_graph = {}
    @graph.each do |vertex, neighbors|
      neighbors.each do |neighbor|
        transposed_graph[neighbor] = [] unless transposed_graph.has_key? neighbor
        transposed_graph[neighbor] << vertex
      end
    end
    transposed_graph
  end
  
  def dfs(graph, current_vertex)
    # ret = []
    # @vertex_states[current_vertex] = GRAY
    # if graph.has_key? current_vertex
    #   graph[current_vertex].each do |neighbor|
    #     if @vertex_states.has_key?(neighbor) && @vertex_states[neighbor] == WHITE
    #       ret.push(dfs(graph, neighbor)).flatten!
    #     end
    #   end
    # end
    # @vertex_states[current_vertex] = BLACK
    # ret << current_vertex
    # ret = []
    # stack = [current_vertex]
    # until stack.empty?
    #   vertex = stack.pop
    #   if @vertex_states[vertex] == WHITE
    #     @vertex_states[vertex] = BLACK
    #     if graph.has_key? vertex
    #       graph[vertex].each do |neighbor|
    #         stack.push neighbor
    #       end
    #     end
    #     ret.push vertex
    #   end
    # end
    # ret
    @traversal.traverse(graph, current_vertex)
  end
end
