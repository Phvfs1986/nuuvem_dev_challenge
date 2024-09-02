class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @merchant_items = @merchant.items
  end
end
