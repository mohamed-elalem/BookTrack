module BooksHelper
  def book_completed_percentage(book)
    return 0 if book.chapters.length.zero?
    book.chapters.completed.pages.to_f / book.chapters.pages.to_f
  end

  def book_completed_percentage_for_html(book)
    (book_completed_percentage(book) * 100).to_i
  end

  def suitable_color(book)
    color_levels = %w[danger warning info primary success]
    color_levels[(book_completed_percentage(book) * (color_levels.length - 1)).to_i]
  end

  def load_inverted_dependency_graph_for(book)
    edges = Dependency.find_each.collect do |r|
      [r.child_id, r.parent_id]
    end
    extract_forest_for_vertex(edges, book.id)
  end

  def extract_forest_for_vertex(edges, vertex)
    uf = UnionFind.new
    edges.each do |r|
      uf.union(r[0], r[1])
    end
    edges = clean_edges(edges, uf, vertex)
    graph = Graph.new do |e|
      e = edges
    end
  end

  def clean_edges(edges, sets, vertex)
    compact_edges = []
    edges.each do |edge|
      child = edge[0]
      if sets.is_same_set(vertex, child)
        compact_edges << edge
      end
    end
    compact_edges
  end

  def clean_graph(graph, needed_vertices)
    graph.delete_if { |key, _| needed_vertices.exclude? key }
    graph.transform_values do |neighbors|
      neighbors.delete_if { |neighbor| needed_vertices.exclude? neighbor }
    end
    graph
  end

  def delete_unneeded_priorities(priorities, book)
    specified_priority = get_specified_priority(priorities, book.id)
    priorities.delete_if { |key, _| key > specified_priority }  
  end
  
  def get_specified_priority(priorities, id)
    priority = nil
    priorities.keys.reverse.each do |key|
      break unless priority.nil?
      priorities[key].each do |book_id|
        break unless priority.nil?
        priority = key if book_id == id
      end
    end
    priority
  end

  def rearrange_priorities(priorities)
    max_priority = priorities.keys.max
    priorities.transform_keys { |key| max_priority - key + 1 }.sort_by { |key, _| key }.to_h
  end

end
