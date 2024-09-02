class Item < ApplicationRecord
  has_many :transactions

  validates :description, presence: true
  validates :price, presence: true, numericality: {greater_than: 0.0}
end
