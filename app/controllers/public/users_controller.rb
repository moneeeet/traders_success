class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(2)
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

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def unsubscribe
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def user_state
    @user = User.find_by(email: params[:user][:email]) #emailからuserを探す
    if @user　　　#もしアカウントが見つかれば
      if @user.valid_password?(params[:user][:password]) && @user.user_status
      #@userのパスワードが有効かつ退会済み(user_status == true)ならば
        flash[:notice] = 'お客様のアカウントは現在ご使用できません。'
        redirect_to new_user_registration_path #新規登録画面へ遷移させる
      end
    end
  end


  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end
end
