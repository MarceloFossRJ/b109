class ManageCommentsController < ApplicationController
  before_filter :login_required
  before_filter :admin_required
  
  # GET /manage_comments
  # GET /manage_comments.json
  def index

    @q = Comment.search(params[:q])
    @comments = @q.result(:distinct => true).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
    @q.build_condition
     
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
  
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to manage_comments_path, notice: 'Comment was successfully updated.'  }
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
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
      format.js   { render :nothing => true } 
    end
  end
  
  private

    def sort_column
      Comment.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
