class TransactionImport < ApplicationRecord
  has_one_attached :order_file
  has_many :transactions

  validate :order_file_present

  IMPORT_STATUS = %i[initializing enqueued processing finished error]

  def filename
    order_file.blob.filename
  end

  def update_file_total_income
    update(
      file_total_income: transactions.includes(:item).sum { |transaction| transaction.item.price * transaction.count }
    )
  end

  def change_status(status)
    update(import_status: status) if IMPORT_STATUS.include?(status)
  end

  private

  def order_file_present
    nil unless order_file.attached?
  end
end
