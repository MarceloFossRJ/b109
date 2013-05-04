class LoginController < ApplicationController
  #layout "admin"

  #before_filter :login_required, :except=>['login']
   def index
     session[:uid] = nil
     session[:user_id] = nil
   end
   
   def create
    #if request.post?
      user = User.find(:first, :conditions=>["login = ?", params[:user][:login]])
      session[:uid] = user
      
      
      if session[:uid] == User.authenticate(params[:user][:login], params[:user][:password])
        #flash[:success]  = "Login successful"
        #redirect_to_stored
        session[:user_id] = user.id
        
        redirect_to blogs_url
      else
        if session[:user_id]  
          session[:user_id] = nil
        end
        session[:uid] = nil
        flash[:warning] = "Login unsuccessful"
        redirect_to :action => 'index'
      end
    #end
  end


  def destroy
    session[:user_id] = nil
    session[:uid] = nil
    flash[:message] = 'Logged out'
    redirect_to users_url
  end
end
