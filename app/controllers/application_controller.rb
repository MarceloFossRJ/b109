class ApplicationController < ActionController::Base
  protect_from_forgery
  WillPaginate.per_page = Parameter.records_per_page
  
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

    def admin_required
      login_required
      if current_user.is_admin
          return true
      else
          return unauthorized
          #return false
      end
    end

    def redirect_to_stored
      if return_to = session[:return_to]
        session[:return_to]=nil
        redirect_to_url(return_to)
      else
        redirect_to users_url
      end
    end

    class UnauthorizedException < Exception; 
    end

    private
      def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end
      helper_method :current_user
      
      protected

      def unauthorized
        render status: 401, template: "/errors/unauthorized.html.erb"
        false
      end

      def not_found
        render status: 404, template: "/errors/not_found.html.erb"
        false
      end      
end
