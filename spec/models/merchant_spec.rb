require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      merchant = create(:merchant)
      expect(merchant).to be_valid
    end

    it "is invalid without a name" do
      merchant = build(:merchant, name: nil, address: "Estrada do Cafunda 200")
      expect(merchant).to_not be_valid
      expect(merchant.errors[:name]).to include("can't be blank")
    end

    it "is invalid without an address" do
      merchant = build(:merchant, address: nil)
      expect(merchant).to_not be_valid
      expect(merchant.errors[:address]).to include("can't be blank")
    end
  end
end
