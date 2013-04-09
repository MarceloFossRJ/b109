class PostsController < ApplicationController
  before_filter :login_required
  before_filter :admin_required
  
  # GET /posts
  # GET /posts.json
  def index

    @q = Post.search(params[:q])
    @posts = @q.result(:distinct => true).order(sort_column + ' ' + sort_direction).paginate(:per_page => 5, :page => params[:page])
    @q.build_condition
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    
#    @taggable = @post
#    @tags = @taggable.tags
#    @tag = Tag.new
    
#    @commentable = @post
#    @comments = @commentable.comments
#    @comment = Comment.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
  #  @post.tags.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    
#    @taggable = @post
#    @tags = @taggable.tags
#    @tag = Tag.new
    
#    @commentable = @post
#    @comments = @commentable.comments
#    @comment = Comment.new
  end

  # POST /posts
  # POST /posts.json
  def create
    params[:post][:user_id] = current_user.id
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    params[:post][:user_id] = current_user.id
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
  
  private

    def sort_column
      Post.column_names.include?(params[:sort]) ? params[:sort] : "title"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end  
end
