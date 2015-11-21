class SubsController < ApplicationController
  before_action :logged_in?, only: [:new, :create, :edit, :update]
  before_action :my_sub?, only: [:edit, :update]

  def my_sub?
    current_user.id == Sub.find(params[:id]).moderator_id
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
