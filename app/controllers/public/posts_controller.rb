class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_normal_user, only: [:new, :create, :destroy, :update, :edit ]

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは投稿できません。'
    end
  end

  def new
     @post = Post.new
  end

  def index
    p params
    if params[:name].present?
      @posts = Post.joins(:tags).merge(Tag.where(name: params[:name])).order(created_at: :desc).page(params[:page]).per(6)
    else
     @posts =Post.order(created_at: :desc).page(params[:page]).per(6)
    end
     @post = Post.new

     if params[:tag_ids]
      @posts = []
      params[:tag_ids].each do |key, value|
        @posts += Tag.find_by(name: key).posts if value == "1"
      end
      @posts.uniq!
     end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_post_path(@post)
    else
      render "edit"
    end
  end

  def create
    @posts = Post.all
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to public_post_path(@post)
    else
     if params[:tag]
      Tag.create(name: params[:tag])
     end
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
    redirect_to public_user_path(current_user)
    else
    render 'show'
    end
  end

  def search
    @posts = Post.search(params[:keyword], params[:page])
    @keyword = params[:keyword]
    render "index"
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :image, tag_ids: [])
  end

  def post_search_params
    byebug
  end
end