class Book < ApplicationRecord
  has_many :chapters
  validates :name, presence: true, length: {minumum: 3, maximum: 30}
  validates :description, length: {maximum: 1.kilobyte}
  
end
