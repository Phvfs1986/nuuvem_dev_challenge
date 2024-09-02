class TransactionImport < ApplicationRecord
  has_one_attached :order_file
  has_many :transactions

  def filename
    order_file.blob.filename
  end

  def update_file_total_income
    update(
      file_total_income: transactions.includes(:item).sum { |transaction| transaction.item.price * transaction.count }
    )
  end
end
