class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :deadline

      t.timestamps null: false
    end
  end
end
