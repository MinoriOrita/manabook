class Rental < ActiveRecord::Base
  validates :user_id,{presence:true}
  validates :book_id,{presence:true}

  def user
    return User.where(book_id: self.book_id)
  end

  def book
    return Book.find_by(id: self.book_id)
  end
end
