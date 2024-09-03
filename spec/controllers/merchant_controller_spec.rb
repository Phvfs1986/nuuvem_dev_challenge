# spec/controllers/merchants_controller_spec.rb
require "rails_helper"

RSpec.describe MerchantsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #show" do
    let(:merchant) { create(:merchant) }
    let!(:items) { create_list(:item, 3) }
    let!(:merchant_items) { items.map { |item| create(:merchant_item, merchant: merchant, item: item) } }

    before do
      @user = create(:user)
      sign_in @user
    end

    it "assigns the requested merchant to @merchant" do
      get :show, params: {id: merchant.id}
      expect(assigns(:merchant)).to eq(merchant)
    end

    it "assigns the merchant's items to @merchant_items" do
      get :show, params: {id: merchant.id}
      expect(assigns(:merchant_items)).to match_array(items)
    end

    it "renders the show template" do
      get :show, params: {id: merchant.id}
      expect(response).to render_template(:show)
    end
  end
end
