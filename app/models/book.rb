class Book < ApplicationRecord
  include BooksHelper

  has_many :chapters
  has_many :book_parents, class_name: 'Dependency', foreign_key: :child_id
  has_many :book_children, class_name: 'Dependency', foreign_key: :parent_id

  has_many :parents, through: :book_parents
  has_many :children, through: :book_children
  
  before_save :contains_cycle?

  validates :name, presence: true, length: {minumum: 3, maximum: 100}
  validates :description, length: {maximum: 1.kilobyte}

  accepts_nested_attributes_for :children, allow_destroy: true
  
  scope :others, -> (id) { where('id != ?', id) }

  def others
    Book.all.where('id != ?', id)
  end

  private
  def contains_cycle?
    old_dependencies = Dependency.all
    new_dependencies = book_children
    dependencies = old_dependencies + new_dependencies - (old_dependencies & new_dependencies)
    edges = dependencies.collect { |r| [r.parent_id, r.child_id] }
    extract_forest_for_vertex(edges, self.id)
    graph = Graph.new do |e|
      e = edges
    end
    cycles = graph.get_cycles
    format_error_messages_for_circular_dependency cycles unless cycles.empty?
    throw(:abort) unless cycles.length.zero?
  end

  def format_error_messages_for_circular_dependency(cycles) 
    cycles.each_with_index do |cycle, index|
      error_message = cycle.map { |book_id| Book.find(book_id) }.map(&:name).join(' -> ')
      self.errors.add("Cycle ##{index}", error_message)
    end
  end
  
end
