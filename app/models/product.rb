class Product < ApplicationRecord
  belongs_to :category
  validates :product_number, uniqueness: true
  validates :name, presence: true
end
