class NotifyDependencyChangeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @graph = Graph.new do |edges|
      edges = Dependency.all.collect { |r| [r.parent_id, r.child_id] }
    end
  end
end
