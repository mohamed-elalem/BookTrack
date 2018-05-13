class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.integer :number_of_chapter
      t.string :name
      t.integer :number_of_pages
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
