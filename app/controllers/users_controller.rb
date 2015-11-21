class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      login!(user)
      redirect_to subs_url
    else
      render :new
    end
  end

  def show
    @user = current_user
    render :show
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
