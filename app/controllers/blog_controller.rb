class BlogController < ApplicationController
  def index
    
    @q = Post.search(params[:q])
    #@blogs = Post.where("is_published = ?", true).order("created_at").reverse_order.paginate(:per_page => 3, :page => params[:page])
    @blogs = @q.result(:distinct => true).order(sort_column + ' ' + sort_direction).paginate(:per_page => 3, :page => params[:page])
    @q.build_condition
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end

  def show
    @blog = Post.find(params[:id])

    @q = Post.search(params[:q])
    #@blogs = Post.where("is_published = ?", true).order("created_at").reverse_order.paginate(:per_page => 3, :page => params[:page])
    @blogs = @q.result(:distinct => true).order(sort_column + ' ' + sort_direction).paginate(:per_page => 3, :page => params[:page])
    @q.build_condition
            
#    @comments = @commentable.comments
    @comment = Comment.new

    @taggable = @blog
    @tags = @taggable.tags
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end
  
  private

    def sort_column
      Post.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end  
end
