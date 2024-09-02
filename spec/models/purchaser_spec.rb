require "rails_helper"

RSpec.describe Purchaser, type: :model do
  it "is valid with a name" do
    purchaser = Purchaser.new(name: "John Doe")
    expect(purchaser).to be_valid
  end

  it "is invalid without a name" do
    purchaser = Purchaser.new(name: nil)
    expect(purchaser).not_to be_valid
  end
end
