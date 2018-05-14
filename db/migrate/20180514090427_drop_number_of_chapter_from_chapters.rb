class DropNumberOfChapterFromChapters < ActiveRecord::Migration[5.2]
  def change
    remove_column :chapters, :number_of_chapter
  end
end
