class ItemSerializer < ApplicationSerializer
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TagHelper

  attributes :description, :price

  def initialize(item)
    @item = item
  end

  def description
    @item.description
  end

  def price
    content_tag(:strong, number_to_currency(@item.price))
  end
end
