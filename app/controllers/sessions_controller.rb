class SessionsController < ApplicationController
  
  def create
    user = User.find_by_email(user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to session.delete(:return_to) || root_path, notice: 'You have been signed in.'
    else
      flash.now.alert = 'Email or password is invalid.'
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'You have been signed out.'
  end

  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user].permit!
    end
    
end
