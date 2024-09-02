require "test_helper"

class PurchaserTest < ActiveSupport::TestCase
  test "should not save without name" do
    purchaser = Purchaser.new
    assert_not purchaser.save, "Saved the purchaser without a name"
  end
end
