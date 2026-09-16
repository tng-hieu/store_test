class AddIndexToProduct < ActiveRecord::Migration[8.1]
  def change
    add_index :products, :code, unique: true, where: "is_deleted = false"
  end
end
