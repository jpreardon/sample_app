class PasswordResetsController < ApplicationController
  def new
  end
  
  def edit
  end
  
  def create
    flash_message = "Email sent to #{params[:password_reset][:email].downcase} with password reset instructions."
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = flash_message
      redirect_to root_url
    else
      # Not really, but we don't want to broadcast whether a malicious party has found a
      # valid email address or not. From an experience standpoint, perhaps the text 
      # could be a bit more honest, like, "we'll send it if we find it".
      flash[:info] = flash_message
      redirect_to root_url
    end
  end
  
end
