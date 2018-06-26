module SuggestionsHelper
  def graph_to_d3_hash(graph)
    hash = {}
    hash = generate_nodes(hash, graph)
    hash = generate_links(hash, graph)
  end
  
  # def graph_to_d3_hash(graph)
  #   {
  #     direction: "downward",
  #   }.merge(generate_graph_for graph)
  # end

  private

  # def generate_hash_for(graph)
  #   @visited = {}
  #   @cache
  #   graph.keys.each do |source|
  #     dfs_and_cache(graph, source)
  #   end
  # end

  # def dfs_and_cache(graph, source)

  # end

  # end

  def generate_nodes(hash, graph)
    hash[:nodes] = []
    hash[:mapper] = {}
    graph.keys.each_with_index do |source, index|
      hash[:mapper][source] = index
      hash[:nodes] << {
        data: {
          name: source,
          label: source,
          id: index
        }
      }
    end
    hash
  end

  def generate_nodes(hash, graph)
    
  end

  def generate_links(hash, graph)
    hash[:edges] = []
    graph.each do |source, destinations|
      destinations.each do |destination|
        hash[:edges] << {
          data: {
            source: hash[:mapper][source],
            target: hash[:mapper][destination]
          }
        }
      end
    end
    hash
  end

  def generate_links(hash, graph)
    hash = []
    graph.each do |source, destinations|
      hash << {
        name: source,
        size: 10,
        imports: destinations
      }
    end
    hash
  end
end
