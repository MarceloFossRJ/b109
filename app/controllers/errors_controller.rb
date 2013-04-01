class ErrorsController < ApplicationController
  def unauthorized
  end

  def not_found
  end

  def error
  end

  protected

   # The exception that resulted in this error action being called can be accessed from
   # the env. From there you can get a backtrace and/or message or whatever else is stored
   # in the exception object.
   def the_exception
     @e ||= env["action_dispatch.exception"]
   end
 
end
