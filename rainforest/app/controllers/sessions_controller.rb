class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to products_url, :notice => "Logged in, good job!"
  	else
  		flash.now[:alert] = "Invalid Email Or Password"
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to products_url, :notice => "Logged Out, dood!"
  end
end
