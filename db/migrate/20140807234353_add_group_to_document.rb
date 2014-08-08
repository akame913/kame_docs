class AddGroupToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :group, :string
    add_column :documents, :group_dl_allow, :boolean, default: false
    add_column :documents, :other_dl_allow, :boolean, default: false
  end
end
