class BlogController < ApplicationController
  def index
    @blogs = Post.where("is_published = ?", true).order("created_at").reverse_order.paginate(:per_page => 3, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end

  def show
    @blog = Post.find(params[:id])
        
    @commentable = @blog
    @comments = @commentable.comments
    @comment = Comment.new

    @taggable = @blog
    @tags = @taggable.tags
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end
end
