module SessionsHelper
  def sign_in(user)
    cookies.permanent[:auth_token] = user.email
    current_user = user
  end
  
  def sign_out
    cookies.delete(:auth_token)
    current_user= nil
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def current_user
    @current_user ||= user_from_auth_token
  end
  
  def signed_in?
    !(current_user.nil?)
  end
  
  def authenticate
     deny_access unless signed_in?
  end
  
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page"
  end

  private
    def user_from_auth_token
      userEmail = remember_token
      User.find_by_email(userEmail)
    end
    
    def remember_token
      cookies[:auth_token] || nil
    end
end
