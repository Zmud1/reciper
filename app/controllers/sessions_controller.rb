class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user) 
      redirect_back_or user
      flash[:success] = "Hello #{user.name}! Welcome back!"
      else
      flash.now[:danger] = "You need to activate the account first!"
      render 'new' 
      end
    else
      flash.now[:danger] = "Error! Invalid email/password combination!"
      render 'new'
    end
  end


  def destroy
   log_out if logged_in?
    redirect_to root_url
  end 
  
end
