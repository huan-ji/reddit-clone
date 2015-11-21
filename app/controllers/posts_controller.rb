class PostsController < ApplicationController
  before_action :logged_in?, only: [:new, :create, :edit, :update]
  before_action :my_post?, only: [:edit, :update]

  def my_post?
    current_user.id == Post.find(params[:id]).author_id
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
    render :index
  end

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      fail
      @post = Post.new
      @subs = Sub.all
      render :new
    end
  end

  def edit
    @subs = Sub.all
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids)
  end
end
