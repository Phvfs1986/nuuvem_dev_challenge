class FileProcessor
  require 'csv'

  def self.process(file)
    file_upload = FileUpload.create(uploaded_at: Time.current)

    CSV.foreach(file.path, col_sep: "\t", headers: true) do |row|
      purchaser_name = row['purchaser name']
      item_description = row['item description']
      count = row['purchase count'].to_i
      item_price = row['item price'].to_f
      merchant_address = row['merchant address']
      merchant_name = row['merchant name']

      purchaser = Purchaser.find_or_create_by(name: purchaser_name)
      merchant = Merchant.find_or_create_by(name: merchant_name, address: merchant_address)
      item = Item.find_or_create_by(description: item_description, price: item_price)

      Transaction.create(purchaser:, item:, count:, merchant:, file_upload:)
    end
  end
end
