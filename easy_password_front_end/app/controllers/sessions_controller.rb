class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      login(user)
      redirect_to user
    else
      flash.now[:danger] = "Invalid email and password combination!"
      render 'new'
    end
  end

  def delete
    logout
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end

  private 
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
