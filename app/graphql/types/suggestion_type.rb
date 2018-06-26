class Types::SuggestionType < Types::BaseObject
  field :book, Types::BookType, null: false
  field :priority, Integer, null: false

  def book
    Book.find(object[:vertex])
  end

  def priority
    object[:priority]
  end
end
