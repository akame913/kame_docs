# encoding: utf-8

class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @documents = current_user.documents.paginate(page: params[:page], per_page: 10)
    end
  end

  def help
  end

  def about
  end
end
