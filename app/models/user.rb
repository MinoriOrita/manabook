class User < ActiveRecord::Base
  has_secure_password

  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true, format:{with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}}
  has_many :reviews

  def rental
    return Rental.where(user_id: self.id)
  end
end
