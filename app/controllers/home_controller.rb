class HomeController < ApplicationController
  before_action :forbid_login_user,{only:[:after_login_to_post]}
  before_action :authenticate_user,{only:[:after_login_to_post]} 
  def top
  end
  def after_login_to_post
    if session[:rental_reserve]
      @book = Book.find_by(id: session[:rental_reserve])
      @book.status = "貸出中"
      @book.save
      @rental = Rental.new(
        user_id: @current_user.id,
        book_id: session[:rental_reserve])
      @rental.save
      session[:rental_reserve] = nil
      flash[:notice]="貸出完了"
      redirect_to("/books/#{@book.id}")
    else
      redirect_to root_path
    end
  end
end
