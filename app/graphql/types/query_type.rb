class Types::QueryType < Types::BaseObject
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :test_field, String, null: false,
    description: "An example field added by the generator"
  
  field :books, [Types::BookType], null: false do
    argument :page, Integer, required: false, default_value: 1
  end
  field :book, Types::BookType, null: false do
    argument :id, ID, required: true
  end

  field :books_pagination_pages_number, Integer, null: false

  field :suggestions, [Types::SuggestionType], null: false
  
  def test_field
    "Hello World!"
  end

  def books(page:)
    Book.page(page || 1)
  end
  
  def books_pagination_pages_number
    Book.page.total_pages
  end


  def book(id:)
    Book.find(id)
  end

  def suggestions
    Graph.new do |edges|
      edges = Dependency.all.collect do |r|
        [
          r.parent.id,
          r.child.id
        ]
      end
    end.prioritize
  end
end
