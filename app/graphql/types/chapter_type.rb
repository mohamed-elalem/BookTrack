class Types::ChapterType < Types::BaseObject
  field :name, String, null: false
  field :description, String, null: true
  field :number_of_pages, String, null: false
  field :is_read, Boolean, null: false
end
