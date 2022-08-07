class Public::HomesController < ApplicationController
  def top
      @posts = Post.page(params[:page]).per(3)
  end

  def post_params
    params.require(:post).permit(:title, :image, :body)
  end
end
