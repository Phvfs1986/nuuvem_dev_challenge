class Merchant < ApplicationRecord
  has_many :transactions
  has_many :items, -> { distinct }, through: :transactions

  validates :name, :address, presence: true
end
