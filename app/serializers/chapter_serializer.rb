class ChapterSerializer < ActiveModel::Serializer
  belongs_to :book
  
  attributes :name, :number_of_pages, :is_read
end
