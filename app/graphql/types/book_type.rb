class Types::BookType < Types::BaseObject

  field :id, ID, null: false
  field :name, String, null: false
  field :description, String, null: true
  field :chapters, [Types::ChapterType], null: false
  field :pages, Integer, null: true
  field :children, [Types::BookType], null: false
  field :parents, [Types::BookType], null: false

  def pages
    object.chapters.pages
  end

end
