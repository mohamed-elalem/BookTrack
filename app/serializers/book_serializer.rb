class BookSerializer < ActiveModel::Serializer
  has_many :chapters

  attributes :name, :description, :created_at
end
