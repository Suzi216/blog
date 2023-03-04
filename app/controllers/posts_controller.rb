class PostsController < ApplicationController
  def index
    @user= current_user
    @posts = Post.all.where(author_id: @user.id)
    # @user = User.find(params[:author_id])
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
    @comment= Comment
    # @comments/ = @post.comments
  end

  def create
    @post=Post.new(params.require(:post).permit(:title , :text))
    @user = current_user
    @post.author_id = @user.id
    if @post.save
      redirect_to user_posts_path(@user)
    else
      render :new
    end
  end

  def new
      @post =Post.new
  end
  

end
