class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @posts = Post.all
  end

  def edit
     @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
       redirect_to user_path(current_user)
    end
  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_user_path(@user)
    else
      render :edit
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end
end
