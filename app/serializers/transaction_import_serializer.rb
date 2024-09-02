class TransactionImportSerializer < ApplicationSerializer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TagHelper

  attributes :uploaded_at, :file_total_income, actions: "Custom Actions Label"

  def initialize(transaction_import)
    @transaction_import = transaction_import
  end

  def uploaded_at
    @transaction_import.uploaded_at.strftime("%d/%m/%Y at %H:%M")
  end

  def file_total_income
    number_to_currency(@transaction_import.file_total_income, unit: "$")
  end

  def download_link
    order_file = @transaction_import.order_file
    content_tag(
      :span, helpers.link_to(order_file.filename, rails_blob_path(order_file, only_path: true), class: "underline")
    )
  end

  def actions
    show_link = helpers.link_to("Show", transaction_import_path(@transaction_import))
    download_link = helpers.link_to("Download File", rails_blob_path(@transaction_import.order_file, only_path: true))

    helpers.safe_join(
      [show_link, content_tag(:span, download_link, class: "underline")], " | "
    )
  end

  private

  def helpers
    ActionController::Base.helpers
  end
end
