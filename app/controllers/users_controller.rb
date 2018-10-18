class UsersController < ApplicationController
  before_action :forbid_login_user,{only:[:new,:create,:login_form,:login]}
  before_action :forbid_login_admin_user,{only:[:login_form,:login]}
  before_action :authenticate_user,{only:[:show,:edit,:update,:destroy]}
  def new
    @user = User.new
  end
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    if @user.save
      session[:user_id]=@user.id
      redirect_to("/books/index")
    else
      render("users/new")
    end
  end
  def show
    @user = User.find_by(id: @current_user.id)
    @histories = History.where(user_id: @user.id)
  end
  def login_form
  end
  def login
    @user=User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      if @user.admin == false
        if session[:rental_reserve]
          redirect_to("/after_login_to_post")
        else
          redirect_to("/books/index")
        end
     else
        redirect_to("/admin")
     end
    else
      @error_message="メールアドレスまたはパスワードが間違っています"
      @email=params[:email]
      @password=params[:password]
      render("/users/login_form")
    end
  end
  def logout
    session[:user_id]=nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if @user.save
      flash[:notice]="ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("/users/edit")
    end
  end
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice]="削除されました"
    redirect_to("/")
  end
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to("/books/index")
    end
  end

end
