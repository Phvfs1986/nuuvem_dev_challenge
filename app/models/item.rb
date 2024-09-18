class Item < ApplicationRecord
  has_many :transactions
  has_many :merchants, -> { distinct }, through: :transactions
  has_many :price_histories, dependent: :destroy

  validates :description, presence: true

  def current_price
    price_histories.order(effective_at: :desc).first&.price
  end
end
