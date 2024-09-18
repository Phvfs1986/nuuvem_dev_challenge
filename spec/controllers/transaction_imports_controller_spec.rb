require "rails_helper"

RSpec.describe TransactionImportsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:transaction_import) { create(:transaction_import, :with_valid_file) }

  before do
    @user = create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "assigns all transaction imports to @transaction_imports" do
      get :index
      expect(assigns(:transaction_imports)).to eq([transaction_import])
    end
  end

  describe "GET #show" do
    it "assigns the requested transaction import to @transaction_import" do
      get :show, params: {id: transaction_import.id}
      expect(assigns(:transaction_import)).to be_a(TransactionImportDecorator)
    end

    it "paginates the transactions" do
      create_list(:transaction, 30, transaction_import:)
      get :show, params: {id: transaction_import.id}
      expect(assigns(:pagy)).not_to be_nil
      expect(assigns(:transactions).count).to eq(20)
    end
  end

  describe "GET #new" do
    it "assigns a new TransactionImport to @transaction_import" do
      get :new
      expect(assigns(:transaction_import)).to be_a_new(TransactionImport)
    end
  end

  describe "POST #create" do
    let(:file) { fixture_file_upload("example_input.tab", "text/tab-separated-values") }
    let(:transaction_import_params) { {transaction_import: {order_file: file}} }
    let(:service) { instance_double(Transactions::ImportProcessor, call: transaction_import) }
    let(:transaction_import) { build_stubbed(:transaction_import) }

    before do
      allow(Transactions::ImportProcessor).to receive(:new).and_return(service)
    end

    context "when the transaction import is successfully created" do
      before do
        allow(transaction_import).to receive(:persisted?).and_return(true)
        post :create, params: transaction_import_params
      end

      it "redirects to the index page" do
        expect(response).to redirect_to(action: :index)
      end
    end

    context "when the transaction import fails to be created" do
      before do
        allow(transaction_import).to receive(:persisted?).and_return(false)
        allow(transaction_import).to receive_message_chain(:errors, :full_messages).and_return(["Error message"])
        post :create, params: transaction_import_params
      end

      it "renders the new template with a bad request status" do
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:bad_request)
      end

      it "sets a flash alert with the error messages" do
        expect(flash.now[:alert]).to eq("Failed to process the file: Error message")
      end
    end
  end
end
