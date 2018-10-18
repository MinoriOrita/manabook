class AdminController < ApplicationController
  before_action :admin_user,{only:[:admin_top,:status_change,:destroy]}
  def admin_top
    @books=Book.where(status:"承認前")
  end
  def status_change
    @book = Book.find_by(id: params[:id])
    @book.status = "本棚"
    @book.save
    redirect_to("/books/index")
  end
  def destroy
    @book=Book.find_by(id: params[:id])
    @book.destroy
    flash[:notice]="削除されました"
    redirect_to("/admin")
  end
end
