class HomeController < ApplicationController
  def index
    if params[:p].blank?
      p = Parameter.root_page
      if p == 'blog'
        redirect_to blogs_path
      else
        @home = Page.find_by_title(p)
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @home }        
        end
      end 
    else
      @home = Page.find(params[:p])
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @home }
      end
    end
  end

  def show
  end
end
