class PriceHistory < ApplicationRecord
  belongs_to :item

  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :effective_at, presence: true
end
