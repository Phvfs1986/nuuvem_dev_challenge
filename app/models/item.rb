class Item < ApplicationRecord
  has_many :transactions
  has_many :merchant_items
  has_many :merchants, through: :merchant_items

  validates :description, presence: true
  validates :price, presence: true, numericality: {greater_than: 0.0}
end
