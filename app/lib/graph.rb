class Graph
  attr_accessor :graph
  attr_accessor :cycle_detector, :prioritizer, :traversal

  def initialize
    edges = yield([]) if block_given?
    @graph = build_graph_from edges
    initialize_engine
  end

  def get_cycles
    @cycle_detector.get_cycles
  end

  def prioritize
    @prioritizer.topo_sort
  end

  def set_traversal(traversal)
    @traversal = traversal
  end

  def set_prioritizer(prioritizer)
    @prioritizer = prioritizer
    @prioritizer.graph = @graph
  end

  def traverse(vertex)
    @traversal.traverse(@graph, vertex)
  end

  def reload
    initialize_engine
  end

  private

  def initialize_engine
    initialize_objects
    initialize_values_for_objects
  end

  def initialize_objects
    @cycle_detector = Kosoraju.new(@graph)
    @prioritizer = GraphFactory.make_prioritizer(:kahn)
  end

  def initialize_values_for_objects
    @prioritizer.graph = @graph
  end
  
  def build_graph_from(edges)
    graph = {}
    edges.each do |edge|
      from, to = edge[0], edge[1]
      graph[from] = [] unless graph.has_key? from
      graph[to] = [] unless graph.has_key? to
      graph[from] << to
    end
    graph
  end
end
