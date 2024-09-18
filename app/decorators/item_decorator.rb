class ItemDecorator < ApplicationDecorator
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TagHelper

  attributes :description, :current_price, :effective_at, :initial_price

  def initialize(item)
    @item = item
  end

  def description
    @item.description
  end

  def current_price
    content_tag(:strong, number_to_currency(@item.current_price))
  end

  def effective_at
    content_tag(:strong, @item.effective_at.strftime("%d/%m/%Y"))
  end

  def initial_price
    content_tag(:strong, number_to_currency(@item.initial_price))
  end
end
