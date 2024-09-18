class TransactionsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  def index
    @all_time_total_income = number_to_currency(Transaction.all_time_total_income, unit: "$")
    @total_transactions = Transaction.count
  end
end
