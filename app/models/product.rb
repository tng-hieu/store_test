class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :code, presence: true, uniqueness: { scope: :is_deleted, conditions: -> { where(is_deleted: false) } }
end
