require "rails_helper"

RSpec.describe Item, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      item = build(:item, description: "banana")
      expect(item).to be_valid
    end

    describe "associations" do
      it "has many transactions" do
        association = described_class.reflect_on_association(:transactions)
        expect(association.macro).to eq(:has_many)
      end
    end

    it "is invalid without a description" do
      item = build(:item, description: nil)
      expect(item).to_not be_valid
      expect(item.errors[:description]).to include("can't be blank")
    end
  end

  describe "#current_price" do
    it "returns the most recent price from price_histories" do
      item = create(:item, :with_price_histories)

      expect(item.current_price).to eq(15.0)
    end

    it "returns nil if there are no price_histories" do
      item = create(:item)

      expect(item.current_price).to be_nil
    end
  end

  describe "#effective_at" do
    it "returns the effective_at date of most recent price from price_histories" do
      item = create(:item, :with_price_histories)

      expect(item.effective_at).to be_within(1.second).of(Time.now)
    end

    it "returns nil if there are no price_histories" do
      item = create(:item)

      expect(item.current_price).to be_nil
    end
  end

  describe "#initial_price" do
    it "returns the first price from price_histories" do
      item = create(:item, :with_price_histories)

      expect(item.initial_price).to eq(10.0)
    end

    it "returns nil if there are no price_histories" do
      item = create(:item)

      expect(item.current_price).to be_nil
    end
  end
end
