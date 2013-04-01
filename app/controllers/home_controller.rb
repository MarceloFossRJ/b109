class HomeController < ApplicationController
  def index
    @home = Page.find(params[:p])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @home }
    end
  end

  def show
  end
end
