class CreateDependencies < ActiveRecord::Migration[5.2]
  def change
    create_table :dependencies do |t|
      t.integer :parent_id
      t.integer :child_id
    end
    add_index :dependencies, :parent_id
    add_index :dependencies, :child_id
    add_index :dependencies, [:parent_id, :child_id], unique: true  
  end
end
