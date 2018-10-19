class AddColumnFelicaIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :felica_id, :string
  end
end
