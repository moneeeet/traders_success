class Admin::UsersController < ApplicationController
  def edit
     @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params) #ストロングパラメータを通して更新
      redirect_to admin_reports_path, notice: "#{@user.name}さんの会員ステータスを更新しました"
    else
      render "edit"
    end
  end

  def is_deleted
     @user = User.find(params[:id])

    if  @user.update(is_deleted: params[:user][:is_deleted]) #ストロングパラメータを通して更新
      redirect_to admin_reports_path, n: "#{@user.name}さんの会員ステータスを更新しました"
    else
      render "edit"
    end

  end


  private

  def user_params
    params.require(:user).permit(:user_status)
  end
end
