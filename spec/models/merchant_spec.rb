require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      merchant = build(:merchant, name: "Claudio", address: "Estrada do Cafunda 200")
      expect(merchant).to be_valid
    end

    it "is invalid without a name" do
      merchant = Merchant.new(address: "Estrada do Cafunda 200")
      expect(merchant).to_not be_valid
    end

    it "is invalid without an address" do
      merchant = Merchant.new(name: "Claudio")
      expect(merchant).to_not be_valid
    end
  end
end
