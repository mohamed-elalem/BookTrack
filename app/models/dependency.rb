class Dependency < ApplicationRecord
  belongs_to :parent, class_name: 'Book'
  belongs_to :child, class_name: 'Book'

  validate :self_reference


  private

  def self_reference
    errors.add(:self_referencing, "Self referencing is prohibited #{self.parent_id} -> #{self.child_id}") if self.parent_id == self.child_id
  end
end
