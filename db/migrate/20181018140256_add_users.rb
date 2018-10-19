class AddUsers < ActiveRecord::Migration
  def change
    add_column :users, :signin_status, :string
  end
end
