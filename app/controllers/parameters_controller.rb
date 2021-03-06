class ParametersController < ApplicationController
  before_filter :login_required  
  before_filter :admin_required
  
  # GET /parameters
  # GET /parameters.json
  def index
    #@parameters = Parameter.all
    @q = Parameter.search(params[:q])
    @parameters = @q.result(:distinct => true).order(sort_column + ' ' + sort_direction).paginate( :page => params[:page])
    @q.build_condition
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parameters }
    end
  end

  # GET /parameters/1
  # GET /parameters/1.json
  def show
    @parameter = Parameter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parameter }
    end
  end

  # GET /parameters/new
  # GET /parameters/new.json
  #def new
  #  @parameter = Parameter.new

  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @parameter }
  #  end
  #end

  # GET /parameters/1/edit
  def edit
    @parameter = Parameter.find(params[:id])
  end

  # POST /parameters
  # POST /parameters.json
  #def create
  #  @parameter = Parameter.new(params[:parameter])

  #  respond_to do |format|
  #    if @parameter.save
  #      format.html { redirect_to parameters_path, notice: 'Parameter was successfully created.' }
  #      format.json { render json: @parameter, status: :created, location: @parameter }
  #    else
  #      format.html { render action: "new" }
  #      format.json { render json: @parameter.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PUT /parameters/1
  # PUT /parameters/1.json
  def update
    @parameter = Parameter.find(params[:id])

    respond_to do |format|
      if @parameter.update_attributes(params[:parameter])
        format.html { redirect_to parameters_path, notice: 'Parameter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  def versions
      @versions = Version.where("item_type=?", "Parameter").order('created_at desc').paginate(:page => params[:page])
      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @versions }
      end
  end
  
  # DELETE /parameters/1
  # DELETE /parameters/1.json
  #def destroy
  #  @parameter = Parameter.find(params[:id])
  #  @parameter.destroy

  #  respond_to do |format|
  #    format.html { redirect_to parameters_url }
  #    format.json { head :no_content }
  #  end
  #end
  
  private

    def sort_column
      Parameter.column_names.include?(params[:sort]) ? params[:sort] : "4"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end
