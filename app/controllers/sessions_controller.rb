class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      cookies.signed.permanent[:user_id] = user.id
    end
    redirect_to root_path
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to root_path
  end
end