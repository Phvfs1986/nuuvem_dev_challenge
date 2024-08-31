class Transaction < ApplicationRecord
  belongs_to :purchaser
  belongs_to :item
  belongs_to :merchant
  belongs_to :file_upload

  def self.total_income
    joins(:item).sum("count * price")
  end
end
