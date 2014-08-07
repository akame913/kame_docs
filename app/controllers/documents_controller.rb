# encoding: utf-8

class DocumentsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit]
  #before_action :correct_user,   only: [:edit]
  #before_action :admin_user, only: [:edit, :destroy]
  
  def index
    @documents = Document.paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @document = Document.new
  end

  def create
    #@document = Document.new(document_params)
    @document = current_user.documents.build(document_params)
    if @document.save
      flash[:success] = "Upload document sucess!"
      redirect_to @document
    else
      render 'new'
    end
  end

  def download
    @document = Document.find(params[:document_id])
    send_data(@document.data,
              filename: @document.name,
              type: @document.content_type,
              disposition: "attachment")
  end

  def show
    @document = Document.find(params[:id])
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(document_params)
       flash[:success] = "Document updated"
       redirect_to @document
    else
      render 'edit'
    end
  end

  def destroy
    Document.find(params[:id]).destroy
    flash[:success] = "Document destroyed."
    redirect_to documents_url
  end
          
  private
    # Never trust parameters from the scary internet, only allow the white
    # list through.
    def document_params
      params.require(:document).permit(:description, :uploaded_document)
    end

    def correct_user
      @document = current_user.documents.find_by(id: params[:id])
      redirect_to root_url if @document.nil?
    end
end
