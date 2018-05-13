class AddIsReadToChapters < ActiveRecord::Migration[5.2]
  def change
    add_column :chapters, :is_read, :boolean, default: false
  end
end
