class SessionsController < ApplicationController
  def new
    @page_title = "Sign in"
  end
  
  def create
    user = User.find_by_email(params[:session][:email])
    if user.nil?
      flash.now[:error] = "Invalid eMail"
      
      @page_title = "Sign in"
      render 'new'
    elsif !user.has_password?(params[:session][:password])
      flash.now[:error] = "Invalid password"
      
      @page_title = 'Sign in'
      render 'new'
    else
      sign_in user
      redirect_to root_path
    end
  end
  
  def destroy
     sign_out
     redirect_to root_path
  end
end
