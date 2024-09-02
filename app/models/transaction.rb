class Transaction < ApplicationRecord
  belongs_to :purchaser
  belongs_to :item
  belongs_to :merchant
  belongs_to :transaction_import

  validates :purchaser, :item, :merchant, :transaction_import, presence: true
  validates :count, presence: true, numericality: {greater_than: 0}

  def self.total_income
    includes(:item).sum { |transaction| transaction.item.price * transaction.count }
    # joins(:item).sum("count * price")
  end
end
