class TransactionSerializer
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  def initialize(transaction)
    @transaction = transaction
  end

  def merchant
    @transaction.merchant.name
  end

  def purchaser
    @transaction.purchaser.name
  end

  def item_description
    @transaction.item.description
  end

  def item_price
    format_price(@transaction.item.price)
  end

  def count
    @transaction.count
  end

  def income
    "<strong>#{format_price(@transaction.item.price * @transaction.count)}</strong>".html_safe
  end

  def format_price(price)
    "$#{format("%.2f", price)}"
  end

  class << self
    def attributes
      [
        :merchant,
        :purchaser,
        :item_description,
        :item_price,
        :count,
        :income
      ]
    end

    def merchant_label
      "Merchant"
    end

    def purchaser_label
      "Purchaser"
    end

    def item_description_label
      "Item"
    end

    def item_price_label
      "Price"
    end

    def count_label
      "Quantity"
    end

    def income_label
      "Income"
    end
  end
end
