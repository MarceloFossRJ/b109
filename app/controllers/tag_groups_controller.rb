class TagGroupsController < ApplicationController
  before_filter :login_required
  before_filter :admin_required
  
  # GET /tag_groups
  # GET /tag_groups.json
  def index

    @q = TagGroup.search(params[:q])
    @tag_groups = @q.result(:distinct => true).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
    @q.build_condition

    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tag_groups }
    end
  end

  # GET /tag_groups/1
  # GET /tag_groups/1.json
  def show
    @tag_group = TagGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag_group }
    end
  end

  # GET /tag_groups/new
  # GET /tag_groups/new.json
  def new
    @tag_group = TagGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag_group }
    end
  end

  # GET /tag_groups/1/edit
  def edit
    @tag_group = TagGroup.find(params[:id])
  end

  # POST /tag_groups
  # POST /tag_groups.json
  def create
    @tag_group = TagGroup.new(params[:tag_group])

    respond_to do |format|
      if @tag_group.save
        format.html { redirect_to tag_groups_path, notice: 'Tag group was successfully created.' }
        format.json { render json: @tag_group, status: :created, location: @tag_group }
      else
        format.html { render action: "new" }
        format.json { render json: @tag_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tag_groups/1
  # PUT /tag_groups/1.json
  def update
    @tag_group = TagGroup.find(params[:id])

    respond_to do |format|
      if @tag_group.update_attributes(params[:tag_group])
        format.html { redirect_to tag_groups_path, notice: 'Tag group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_groups/1
  # DELETE /tag_groups/1.json
  def destroy
    @tag_group = TagGroup.find(params[:id])
    @tag_group.destroy

    respond_to do |format|
      format.html { redirect_to tag_groups_url }
      format.json { head :no_content }
    end
  end

  def versions
      @versions = Version.where("item_type=?", "TagGroup").order('created_at desc').paginate(:page => params[:page])
      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @versions }
      end
  end
    
  private

    def sort_column
      TagGroup.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
