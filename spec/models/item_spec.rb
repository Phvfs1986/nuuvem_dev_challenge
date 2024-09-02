require "rails_helper"

RSpec.describe Item, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      item = build(:item, description: "banana", price: 5.0)
      expect(item).to be_valid
    end

    it "is invalid without a description" do
      item = build(:item, description: nil)
      expect(item).to_not be_valid
      expect(item.errors[:description]).to include("can't be blank")
    end

    it "is invalid without a price" do
      item = build(:item, price: nil)
      expect(item).to_not be_valid
      expect(item.errors[:price]).to include("can't be blank")
    end
  end

  describe "associations" do
    it "has many transactions" do
      association = described_class.reflect_on_association(:transactions)
      expect(association.macro).to eq(:has_many)
    end
  end
end
