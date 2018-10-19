class ChangeDatetypeSigninStatusOfUsers < ActiveRecord::Migration
  def change
    change_column :users, :signin_status, :string
  end
end
