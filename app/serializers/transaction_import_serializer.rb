class TransactionImportSerializer
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  def initialize(transaction_import)
    @transaction_import = transaction_import
  end

  def uploaded_at
    @transaction_import.uploaded_at.strftime("%d/%m/%Y at %H:%m")
  end

  def file_total_income
    "$#{@transaction_import.file_total_income}"
  end

  def download_link
    order_file = @transaction_import.order_file
    link_to order_file.filename, Rails.application.routes.url_helpers.rails_blob_path(order_file, only_path: true)
  end

  def actions
    show_link = link_to("Show", transaction_import_path(@transaction_import))
    download_link = link_to("Download File", rails_blob_path(@transaction_import.order_file, only_path: true))

    safe_join([show_link, download_link], " | ")
  end

  class << self
    def attributes
      [
        :uploaded_at,
        :file_total_income,
        :actions
      ]
    end

    def uploaded_at_label
      "Uploaded At"
    end

    def file_total_income_label
      "File Total Income"
    end

    def actions_label
      "Actions"
    end
  end
end
