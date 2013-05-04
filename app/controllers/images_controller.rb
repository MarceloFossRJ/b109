class ImagesController < ApplicationController
  before_filter :login_required  
  before_filter :admin_required
  # GET /images
  # GET /images.json
  def index
    #@images = Image.all

    @q = Image.search(params[:q])
    @images = @q.result(:distinct => true).order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, :page => params[:page])
    @q.build_condition
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    params[:image][:user_id] = current_user.id
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to images_path, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])
    params[:image][:user_id] = current_user.id
    
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to images_path, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end

  private

    def sort_column
      Image.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end  
end