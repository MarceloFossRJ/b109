class LoginController < ApplicationController
  #layout "admin"

  #before_filter :login_required, :except=>['login']
   def index
     session[:uid] = nil
     session[:user_id] = nil
   end
   
   def create
    #if request.post?
      u = User.find(:first, :conditions=>["login = ?", params[:user][:login]])
      session[:uid] = u
      
      if u.nil?
        if session[:user_id]  
          session[:user_id] = nil
        end
        session[:uid] = nil
        flash[:warning] = "Login unsuccessful"
        redirect_to :action => 'index'      
      
      elsif session[:uid] == User.authenticate(params[:user][:login], params[:user][:password])
        #flash[:success]  = "Login successful"
        #redirect_to_stored
        session[:user_id] = u.id
        
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
