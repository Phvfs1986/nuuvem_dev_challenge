require "rails_helper"

RSpec.describe ApplicationSerializer, type: :model do
  subject { described_class }

  before do
    subject.attributes(:name, :age, address: "Address Label")
  end

  describe ".attributes" do
    it "sets and retrieves attributes with labels" do
      expect(subject.get_attributes).to contain_exactly(:name, :age, :address)
      expect(subject.get_labels).to contain_exactly("Name", "Age", "Address Label")
      expect(subject.attributes_with_labels).to eq({name: "Name", age: "Age", address: "Address Label"})
    end

    it "overwrites attributes if same attribute is set" do
      subject.attributes(name: "Another Name")

      expect(subject.attributes_with_labels).to eq({name: "Another Name", age: "Age", address: "Address Label"})
    end
  end

  describe "#attributes" do
    it "returns the class-level attributes" do
      expect(subject.new.attributes).to contain_exactly(:name, :age, :address)
    end
  end

  describe "#labels" do
    it "returns the class-level labels" do
      expect(subject.new.labels).to contain_exactly("Name", "Age", "Address Label")
    end
  end

  describe "#attributes_with_labels" do
    it "returns the class-level attributes with labels" do
      expect(subject.new.attributes_with_labels).to eq({name: "Name", age: "Age", address: "Address Label"})
    end
  end
end
