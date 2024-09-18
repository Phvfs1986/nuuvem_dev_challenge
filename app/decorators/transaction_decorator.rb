class TransactionDecorator < ApplicationDecorator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TagHelper

  attributes :merchant, :purchaser, :item_description, :item_price, :count, :income

  def initialize(transaction)
    @transaction = transaction
  end

  def merchant
    merchant = @transaction.merchant
    helpers.link_to(merchant.name, merchant_path(merchant), class: "underline text-blue-500 pointer")
  end

  def purchaser
    @transaction.purchaser.name
  end

  def item_description
    @transaction.item.description
  end

  def item_price
    number_to_currency(@transaction.price, unit: "$")
  end

  def count
    @transaction.count
  end

  def income
    content_tag(:strong, number_to_currency(@transaction.price * @transaction.count, unit: "$"))
  end

  private

  def helpers
    ActionController::Base.helpers
  end
end
