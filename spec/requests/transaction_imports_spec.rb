require 'rails_helper'

RSpec.describe "TransactionImports", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/transaction_imports/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/transaction_imports/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/transaction_imports/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/transaction_imports/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
