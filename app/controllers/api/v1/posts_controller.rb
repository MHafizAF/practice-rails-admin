class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show update destroy]

  def index 
    @posts = current_user.posts.order("id DESC")
    render json: @posts, status: :ok
  end

  def create 
    @post = Post.new(post_params) 
    
    if @post.save
      render json: @post, status: :ok
    else 
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @post, status: :ok
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy 
    @post.destroy
    render json: @post, status: :ok
  end

  private 

  def post_params 
    params.require(:post).permit(:title, :description).merge(user_id: current_user.id)
  end

  def set_post 
    @post = Post.find_by(id: params[:id])
    render json: { message: "Post not found" }, status: :not_found if @post.blank?
  end
end
