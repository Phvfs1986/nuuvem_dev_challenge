class Merchant < ApplicationRecord
  has_many :transactions
  has_many :merchant_items
  has_many :items, through: :merchant_items

  validates :name, :address, presence: true
end
