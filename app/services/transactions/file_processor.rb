module Transactions
  class FileProcessor
    require "csv"

    def self.process(order_file, transaction_import)
      transaction_control = true

      CSV.foreach(order_file.path, col_sep: "\t", headers: true) do |row|
        purchaser = Purchaser.find_or_create_by(name: row["purchaser name"])
        merchant = Merchant.find_or_create_by(name: row["merchant name"], address: row["merchant address"])
        item = Item.find_or_create_by(description: row["item description"], price: row["item price"])
        count = row["purchase count"]

        transaction_control &&= Transaction.new(purchaser:, item:, count:, merchant:, transaction_import:).save
      end
      transaction_control
    end
  end
end
