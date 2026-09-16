class Category < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :sequence, presence: true
end
