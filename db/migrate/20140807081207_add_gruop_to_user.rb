class AddGruopToUser < ActiveRecord::Migration
  def change
    add_column :users, :group, :string
  end
end
