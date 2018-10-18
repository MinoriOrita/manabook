class ApplicationController < ActionController::Base
before_action :set_current_user
before_action :admin_user
def set_current_user
  @current_user = User.find_by(id: session[:user_id],admin: false)
end
def authenticate_user
  if @current_user==nil
    flash[:notice]="ログインが必要です"
    redirect_to("/login")
  end
end
def authenticate_admin_user
  if @admin_user == nil
    redirect_to("/")
  end
end
def after_sign_in_path_for(resource)
  if session[:after_login_to_post]
    after_login_to_post_path
  else
    root_path
  end
end
def forbid_login_user
  if @set_current_user
    flash[:notice]="すでにログインしています"
    redirect_to("/books/index")
  end
end
def forbid_login_admin_user
   if @admin_user
    flash[:notice]="すでにログインしています"
    redirect_to("/admin")
   end
end
 def admin_user
   @admin_user = User.find_by(id: session[:user_id],admin: true)
 end
end
