class Review < ActiveRecord::Base
  validates :review, {presence: true,length:{maximum:2000}}
  belongs_to :book
end
