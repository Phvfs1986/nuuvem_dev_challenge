require "rails_helper"

RSpec.describe MerchantsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #show" do
    let(:merchant) { create(:merchant) }

    before do
      @user = create(:user)
      sign_in @user
    end

    it "assigns the requested merchant to @merchant" do
      get :show, params: {id: merchant.id}
      expect(assigns(:merchant)).to eq(merchant)
    end

    it "renders the show template" do
      get :show, params: {id: merchant.id}
      expect(response).to render_template(:show)
    end
  end
end
