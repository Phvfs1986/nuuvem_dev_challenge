class TransactionImportSerializer < ApplicationSerializer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TagHelper

  attributes :uploaded_at, :file_total_income, :import_status, actions: "Actions"

  def initialize(transaction_import)
    @transaction_import = transaction_import
  end

  def uploaded_at
    @transaction_import.uploaded_at.strftime("%d/%m/%Y at %H:%M")
  end

  def file_total_income
    number_to_currency(@transaction_import.file_total_income, unit: "$")
  end

  def import_status
    content_tag(:span, class: "bg-blue-100 text-blue-800 text-sm font-medium me-2 px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300") do
      @transaction_import.import_status&.upcase
    end
  end

  def download_link
    order_file = @transaction_import.order_file
    content_tag(
      :span, helpers.link_to(order_file.filename, rails_blob_path(order_file, only_path: true), class: "underline text-blue-500 pointer")
    )
  end

  def actions
    show_link = helpers.link_to("Show", transaction_import_path(@transaction_import), class: "underline text-blue-500 pointer")
    download_link = helpers.link_to("Download File", rails_blob_path(@transaction_import.order_file, only_path: true), class: "underline text-blue-500 pointer")

    helpers.safe_join(
      [show_link, download_link], " | "
    )
  end

  private

  def helpers
    ActionController::Base.helpers
  end
end
