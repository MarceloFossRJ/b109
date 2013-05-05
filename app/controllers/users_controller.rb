class UsersController < ApplicationController
  before_filter :login_required, :except => [:signup, :create_user]
  before_filter :admin_required, :except => [:signup, :create_user]
  
  # GET /users
  # GET /users.json
  def index
    @q = User.search(params[:q])
    @users = @q.result(:distinct => true).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
#    @users = User.order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, :page => params[:page])
    @q.build_condition
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @user.updating_password = false
  	respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  #GET /user/1/change_password
  def change_password
    @user = current_user
  end
  
  #PUT /user/1/change_password
  def update_password
    
    @user = User.find(params[:id])
    if @user == User.authenticate(current_user.login, params[:old_password])
      @user.updating_password = true
  	  respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to users_url, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "change_password" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        flash[:warning] = "Wrong password"
        format.html { render action: "change_password", message: 'Wrong password' }
      end
    end
  end 

  def access_denied
  end
  
  def signup
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end  
  end
  
  def create_user
    params[:user][:is_admin] = false
    params[:user][:is_active] = true
    params[:user][:login] = params[:user][:email]

    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to blogs_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end    
  end
  
  def versions
      @users = Version.where("item_type=?", "User").order('created_at desc').paginate(:page => params[:page])
      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @users }
      end
  end
  
  private

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end 
end
