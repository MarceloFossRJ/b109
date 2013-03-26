class ApplicationController < ActionController::Base
  protect_from_forgery
  
    def login_required
        if session[:uid]
  #        flash[:warning]=session[:uid][:login]
          return true
        end
        #flash[:warning]='Please login to continue'
        session[:return_to] = request.url
        redirect_to login_index_path#login_path#:controller => "admin/cms", :action => "login"
        return false
    end


    def redirect_to_stored
      if return_to = session[:return_to]
        session[:return_to]=nil
        redirect_to_url(return_to)
      else
        redirect_to users_url
      end
    end

    private
      def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end
      helper_method :current_user
end
