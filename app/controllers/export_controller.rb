class ExportController < ApplicationController

  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def export_users
    @users = User.order(:id)
    respond_to do |format|
      format.csv { render text: @users.to_csv }
    end    
  end
  
  def export_categories
    @categories = Category.order(:id)
    respond_to do |format|
      format.csv { send_data @categories.to_csv }
    end    
  end
  def export_posts
    @posts = Post.order(:id)
    respond_to do |format|
      format.csv { send_data @posts.to_csv }
    end    
  end
  def export_pages
    @pages = Page.order(:id)
    respond_to do |format|
      format.csv { render text: @pages.to_csv }
    end    
  end
  def export_comments
    @comments = Comment.order(:id)
    respond_to do |format|
      format.csv { render text: @comments.to_csv }
    end    
  end
  def export_taggroups
    @tag_groups = TagGroup.order(:id)
    respond_to do |format|
      format.csv { render text: @tag_groups.to_csv }
    end    
  end
  def export_tags
    @tags = Tag.order(:id)
    respond_to do |format|
      format.csv { render text: @tags.to_csv }
    end    
  end
  def export_parameters
    @parameters = Parameter.order(:id)
    respond_to do |format|
      format.csv { render text: @parameters.to_csv }
    end    
  end
  def export_media
  end

end
