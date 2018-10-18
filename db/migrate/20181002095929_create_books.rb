class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :category_name
      t.string :category_id
      t.string :ISBN
      t.integer :review_id
      t.integer :applicant
      t.string :status

      t.timestamps null: false
    end
  end
end
