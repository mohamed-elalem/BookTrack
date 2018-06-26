class KahnTopoSort
  
  def graph=(graph)
    @graph = graph
    @indegrees = calculate_indegrees_from graph
  end

  def topo_sort
    queue = Queue.new
    topoSort = []
    parent = {}
    depth = {}
    explored = {}
    depth[-1] = 0
    indegrees = @indegrees.dup
    indegrees.each do |vertex, indegree|
      if indegree.zero?
        queue << vertex
        parent[vertex] = -1
      end
    end
    until queue.empty?
      current_vertex = queue.pop
      if indegrees[current_vertex].zero? && !explored.has_key?(current_vertex)
        explored[current_vertex] = true
        depth[current_vertex] = depth[parent[current_vertex]] + 1
        topoSort << {vertex: current_vertex, priority: depth[current_vertex]}
        if @graph.has_key? current_vertex
          @graph[current_vertex].each do |neighbor|
            parent[neighbor] = current_vertex
            queue << neighbor
            indegrees[neighbor] -= 1
          end
        end
      end
    end
    topoSort
  end

  private

  def calculate_indegrees_from(graph)
    indegrees = {}
    graph.each do |vertex, neighbors|
      indegrees[vertex] = 0 unless indegrees.has_key? vertex
      neighbors.each do |neighbor|
        indegrees[neighbor] = 0 unless indegrees.has_key? neighbor
        indegrees[neighbor] += 1
      end
    end
    indegrees
  end
end
