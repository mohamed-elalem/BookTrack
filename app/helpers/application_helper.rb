module ApplicationHelper
  def get_array_of_hashes_for_nested_resources(params)
    new_params = []
    params.each do |key, values|
      if values.is_a? Array
        values.each do |value|
          new_params << {key.singularize => value }
        end
      end
    end
    new_params
  end

  def excerpt(phrase, width)
    text = phrase[0...width]
    if phrase.length >= width
      text += '***'
    end
    text
  end

  def get_priorities_from(graph)
    priorities = {}
    graph.prioritize.each do |info|
      priorities[info[:priority]] = [] unless priorities.has_key? info[:priority]
      priorities[info[:priority]] << info[:vertex]
    end
    priorities
  end
  def get_book_models_from(priorities)
    inverted_priorities = invert_priority_hash(priorities)
    priorities = {}
    Book.where(id: inverted_priorities.keys).find_each do |book|
      priorities[inverted_priorities[book.id]] = [] if priorities[inverted_priorities[book.id]].nil?
      priorities[inverted_priorities[book.id]] << book
    end
    # priorities.transform_values do |vertices|
    #   # vertices.map! do |vertex|
    #   #   Book.find(vertex)
    #   # end
    #   vertices = Book.find(vertices)
    # end
    priorities.sort.to_h
  end

  def invert_priority_hash(priorities)
    inverted_priorities = {}
    priorities.each do |key, values|
      values.each do |value|
        inverted_priorities[value] = key
      end
    end
    inverted_priorities
  end
end
