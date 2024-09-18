module Transactions
  class FileProcessor
    require "csv"

    def initialize(transaction_import)
      @transaction_import = transaction_import
    end

    def process
      @transaction_import.order_file.open do |file|
        CSV.foreach(file, col_sep: "\t", headers: true) do |row|
          process_row(row)
        end
      end
    rescue => e
      @transaction_import.change_status(:error)
      raise e
    end

    private

    def process_row(row)
      purchaser = find_or_create_purchaser(row["purchaser name"])
      item = find_or_create_item(row["item description"])
      merchant = find_or_create_merchant(row["merchant name"], row["merchant address"])
      price = row["item price"]
      count = row["purchase count"]

      find_or_create_price_history(item, price)

      create_transaction(purchaser, item, merchant, price, count)
    end

    def find_or_create_purchaser(name)
      Purchaser.find_or_create_by(name:)
    end

    def find_or_create_item(description)
      Item.find_or_create_by(description:)
    end

    def find_or_create_merchant(name, address)
      Merchant.find_or_create_by(name:, address:)
    end

    def create_transaction(purchaser, item, merchant, price, count)
      Transaction.create!(purchaser:, item:, merchant:, count:, price:, transaction_import: @transaction_import)
    end

    def find_or_create_price_history(item, price)
      unless item.price_histories.exists?(price:)
        item.price_histories.create(price:, effective_at: Time.now)
      end
    end
  end
end
