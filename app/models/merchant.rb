class Merchant < ApplicationRecord
  has_many :transactions

  validates :name, :address, presence: true
end
