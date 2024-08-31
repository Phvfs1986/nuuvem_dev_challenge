class FileUploadsController < ApplicationController
  def index
    @file_uploads = FileUpload.all
    @total_income = Transaction.total_income
  end

  def new

  end

  def create
    if params[:file].present?
      FileProcessor.process(params[:file])

      flash[:notice] = "File uploaded successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end
end
