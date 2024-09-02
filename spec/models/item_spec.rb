require "rails_helper"

RSpec.describe Item, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      item = Item.new(description: "Product 1", price: 10.0)
      expect(item).to be_valid
    end

    it "is invalid without a description" do
      item = Item.new(price: 10.0)
      expect(item).to_not be_valid
    end

    it "is invalid without a price" do
      item = Item.new(description: "Product 1")
      expect(item).to_not be_valid
    end
  end

  describe "associations" do
    it "has many transactions" do
      association = described_class.reflect_on_association(:transactions)
      expect(association.macro).to eq(:has_many)
    end
  end
end
