class TransactionImport < ApplicationRecord
  has_one_attached :order_file
  has_many :transactions

  IMPORT_STATUS = %i[initializing enqueued processing finished error].freeze

  validates :order_file, attached: true, content_type: [:tab]
  validates :import_status, inclusion: {in: IMPORT_STATUS.map(&:to_s)}

  before_validation :set_default_import_status, on: :create

  def filename
    order_file.blob.filename
  end

  def file_total_income
    transactions.sum("price * count")
  end

  def change_status(import_status)
    update(import_status:) if IMPORT_STATUS.include?(import_status)
  end

  def set_default_import_status
    self.import_status ||= :initializing.to_s
  end
end
