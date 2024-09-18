require "rails_helper"

RSpec.describe PriceHistory, type: :model do
  let(:item) { create(:item) }

  describe "validations" do
    it "is valid with valid attributes" do
      price_history = build(:price_history, item:)
      expect(price_history).to be_valid
    end

    it "is not valid without a price" do
      price_history = build(:price_history, item:, price: nil)
      expect(price_history).to_not be_valid
      expect(price_history.errors[:price]).to include("can't be blank")
    end

    it "is not valid with a negative price" do
      price_history = build(:price_history, item:, price: -1.0)
      expect(price_history).to_not be_valid
      expect(price_history.errors[:price]).to include("must be greater than or equal to 0")
    end

    it "is not valid without an effective_at date" do
      price_history = build(:price_history, item:, effective_at: nil)
      expect(price_history).to_not be_valid
      expect(price_history.errors[:effective_at]).to include("can't be blank")
    end
  end
end
