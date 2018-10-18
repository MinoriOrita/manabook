class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :review
      t.integer :writer
      t.integer :book_id

      t.timestamps null: false
    end
  end
end
