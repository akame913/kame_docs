class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.text :description
      t.string :content_type
      t.binary :data
      
      t.timestamps
    end
  end
end
