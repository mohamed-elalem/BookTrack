class SuggestionsController < ApplicationController
  include SuggestionsHelper

  before_action :set_graph

  def index
    excerpt_width = 15
    @priorities = get_priorities_from(@graph)
    @priorities = get_book_models_from @priorities
    @textual_graph = Graph.new do |edges|
      edges = Dependency.includes(:parent, :child).find_each.collect do |r|
        [
          excerpt(r.parent.name, excerpt_width),
          excerpt(r.child.name, excerpt_width)
        ]
      end
    end
  end

  private

  def set_graph
    @graph = Graph.new do |edges|
      edges = Dependency.find_each.collect { |r| [r.parent_id, r.child_id] }
    end
  end
end
