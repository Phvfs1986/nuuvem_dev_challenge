class ItemDecorator < ApplicationDecorator
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TagHelper

  attributes :description, :current_price

  def initialize(item)
    @item = item
  end

  def description
    @item.description
  end

  def current_price
    content_tag(:strong, number_to_currency(@item.current_price))
  end
end
