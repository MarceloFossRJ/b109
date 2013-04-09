class CommentsController < ApplicationController
  before_filter :load_commentable
  
  # GET /comments
  # GET /comments.json
  def index
    @comments = @commentable.comments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = @commentable.comments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = @commentable.comments.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    login_required
    params[:comment][:user_id] = current_user.id
    params[:comment][:is_published] = true
    params[:comment][:is_validated] = false
    @comment = @commentable.comments.new(params[:comment])
    @blog = Post.find(params[:post_id])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'Comment was successfully created.' }
        format.json { render json: blog_path(@blog), status: :created, location: @commentable }
      else
        format.html {redirect_to blog_path(@blog) }
        format.json { render json: @commentable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
  
  private

    def load_commentable
      resource, id = request.path.split('/')[1,2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end  
end
