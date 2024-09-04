require "rails_helper"

RSpec.describe User, type: :model do
  describe ".from_google" do
    let(:google_user) do
      {
        uid: "2222222222",
        email: "phverissimo@gmail.com"
      }
    end

    context "when user does not exist" do
      it "creates a new user with Google credentials" do
        user = User.from_google(google_user)

        expect(user).to be_persisted
        expect(user.email).to eq(google_user[:email])
        expect(user.provider).to eq("google")
        expect(user.provider_uid).to eq(google_user[:uid])
        expect(user.password).not_to be_nil
      end
    end

    context "when user already exists" do
      before do
        create(:user, email: google_user[:email], provider: "google", provider_uid: google_user[:uid])
      end

      it "finds the existing user" do
        user = User.from_google(google_user)

        expect(user).to be_persisted
        expect(user.email).to eq(google_user[:email])
        expect(user.provider).to eq("google")
        expect(user.provider_uid).to eq(google_user[:uid])
      end
    end
  end
end
