class AddDefaultsToCategories < ActiveRecord::Migration[8.1]
  def change
    change_column_default :categories, :is_active, from: nil, to: true
    change_column_default :categories, :is_delete, from: nil, to: false

    reversible do |dir|
      dir.up do
        Category.where(is_active: nil).update_all(is_active: true)
        Category.where(is_delete: nil).update_all(is_delete: false)
      end
    end

    change_column_null :categories, :is_active, false
    change_column_null :categories, :is_delete, false
  end
end
