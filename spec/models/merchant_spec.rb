require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      merchant = Merchant.new(name: "Merchant 1", address: "123 Street")
      expect(merchant).to be_valid
    end

    it "is invalid without a name" do
      merchant = Merchant.new(address: "123 Street")
      expect(merchant).to_not be_valid
    end

    it "is invalid without an address" do
      merchant = Merchant.new(name: "Merchant 1")
      expect(merchant).to_not be_valid
    end
  end
end
