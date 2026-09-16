class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.integer :sequence
      t.boolean :is_active, default: true
      t.boolean :is_deleted, default: false

      t.timestamps
    end
  end
end
