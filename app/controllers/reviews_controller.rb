class ReviewsController < ApplicationController
before_action :ensure_correct_user,{only: [:edit,:update,:destroy]}
before_action :authenticate_user,{only:[:edit,:update,:destroy]}

def edit
  @review = Review.find_by(id: params[:id])
end
def update
  @review = Review.find_by(id: params[:id])
  @review.review = params[:review]
  @book = Book.find_by(id: @review.book_id)
  if @review.save
    flash[:notice]="書評を編集しました"
    redirect_to("/books/#{@book.id}")
  else
    render("/users/edit")
  end
end
def destroy
  @review = Review.find_by(id: params[:id])
  @review.destroy
  @book = Book.find_by(id:@review.book_id)
  flash[:notice] = "書評を削除しました"
  redirect_to("/books/#{@book.id}")
end
def ensure_correct_user
  @book = Book.find_by(id: params[:id])
  @review = Review.find_by(id: params[:id])
  if @review.writer != @current_user.id
   redirect_to("/books/index")
 end
end
end
