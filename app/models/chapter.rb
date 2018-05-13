class Chapter < ApplicationRecord
  belongs_to :book
  validates :name, presence: true, length: {minumum: 3, maximum: 30}
  validates :number_of_pages, presence: true, numericality: { only_integer: true, greater_than: 0}

  scope :completed, -> { where(is_read: true) }

  scope :pages, -> { sum(:number_of_pages) }
end
