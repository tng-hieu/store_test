class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :code
      t.integer :sequence
      t.boolean :is_active
      t.boolean :is_delete

      t.timestamps
    end
  end
end
