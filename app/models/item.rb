class Item < ApplicationRecord
  has_many :transactions
  has_many :merchants, -> { distinct }, through: :transactions
  has_many :price_histories, -> { order(effective_at: :asc) }, dependent: :destroy

  validates :description, presence: true

  def current_price
    price_histories.last&.price
  end

  def effective_at
    price_histories.last&.effective_at
  end

  def initial_price
    price_histories.first&.price
  end
end
