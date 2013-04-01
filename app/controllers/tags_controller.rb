class TagsController < ApplicationController
  before_filter :load_taggable
  before_filter :admin_required
  
  # GET /tags
  # GET /tags.json
  def index

    @tags = @taggable.tags
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end
  
  def show
    @tag = @taggable.tags.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
    end
  end
  
  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = @taggable.tags.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = @taggable.tags.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @taggable, notice: 'Tag was successfully created.' }
        format.json { render json: post_tags_path, status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @taggable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to post_tags_path, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @taggable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = @taggable.tags.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to post_tags_path, notice: 'Tag was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  private

    def load_taggable
      resource, id = request.path.split('/')[1,2]
      @taggable = resource.singularize.classify.constantize.find(id)
    end
end
