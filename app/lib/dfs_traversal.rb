class DfsTraversal

  BLACK = 2

  def initialize
    @vertex_states = {}
    @depth = {}
  end

  def reload
    initialize
  end

  def traverse(graph, current_vertex)
    return [] if @vertex_states.has_key? current_vertex
    ret = []
    stack = [current_vertex, current_vertex]
    in_path = Set.new
    until stack.empty?
      vertex = stack.pop
      if !@vertex_states.has_key? vertex
        @vertex_states[vertex] = BLACK
        if graph.has_key? vertex
          graph[vertex].each do |neighbor|
            unless @vertex_states.has_key? neighbor
              stack.push neighbor
              stack.push neighbor
            end
          end
        end
      elsif in_path.exclude?(vertex)
        ret.push vertex
        in_path.add vertex
      end
    end
    ret
  end
end