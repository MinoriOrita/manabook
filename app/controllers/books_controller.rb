class BooksController < ApplicationController
   before_action :authenticate_user,{only: [:new,:create,:return,:review_new,:review_create]}
   before_action :ensure_correct_user,{only: [:return]}
   before_action :authenticate_user,{only:[:return]}
  def index
    @books=Book.where(status: ["本棚","貸出中"])
  end
  def show
    @book = Book.find_by(id: params[:id])
    @rental = Rental.find_by(book_id: @book.id)
    @reviews = Review.where(book_id: @book.id)
  end
  def new
    @book = Book.new
    @review = Review.new
  end

  def create
    @book = Book.new(
      title: params[:title],
      author: params[:author],
      ISBN: params[:ISBN],
      category_name: params[:category_name],
      applicant: @current_user.id)
    @book.status = "承認前"
    if @book.save
      @review = Review.new(
        review: params[:review],
        writer: @current_user.id,
        book_id: @book.id)
       if @review.save
         flash[:notice]="申請されました"
         redirect_to("/books/index")
       else
         render("books/new")
       end
    else
      @review = Review.new(
        review: params[:review],
        writer: @current_user.id,
        book_id: @book.id)
      render("books/new")
    end
  end

  def search_results
      keyword = params[:search]
      @books = Book.where("title like '%#{keyword}%' OR author like '%#{keyword}%' OR status like '%#{keyword}%' ")
  end

  def rental
    @book = Book.find_by(id: params[:id])
    if @current_user
     @book.status = "貸出中"
     @book.save
     @rental = Rental.new(
       user_id: @current_user.id,
       book_id: @book.id)
     @rental.save
     flash[:notice]="貸出完了"
     @history = History.new(
       user_id: @current_user.id,
       book_id: @book.id)
     @history.save
     redirect_to("/users/#{@current_user.id}")
    else
      session[:rental_reserve]= @book.id
      redirect_to login_path
    end
  end
  def return
    @book = Book.find_by(id: params[:id])
    @book.status = "本棚"
    @book.save
    @rental = Rental.find_by(book_id: @book.id)
    @rental.destroy
    @rental.save
    flash[:notice]="返却されました"
    redirect_to("/books/index")
  end
  def review_new
    @review = Review.new
    @book = Book.find_by(id: params[:id])
  end
  def review_create
    @book = Book.find_by(id: params[:id])
    @review = Review.new(
      review: params[:review],
      writer: @current_user.id,
      book_id: @book.id)
        # このあたりに「書評書いた人」の定義しなきゃいけない気がする
      if @review.save
        redirect_to("/books/#{@book.id}")
      else
        render("/books/#{@book.id}/new")
      end
  end
  def ensure_correct_user
    @book = Book.find_by(id: params[:id])
    @rental = Rental.find_by(book_id: @book.id)
    if @rental.user_id != @current_user.id
     redirect_to("/books/index")
    end
  end

end
