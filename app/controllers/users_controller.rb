class UsersController < ApplicationController
  before_filter :not_logged_in
  
  def new
    @page_title = "Sign Up"
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to root_path
    else
      @page_title = "Sign Up"
      render "new"
    end
  end
  
  private
    def not_logged_in
      redirect_to root_path and return if signed_in?
    end
end
