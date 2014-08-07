# encoding: utf-8

class Document < ActiveRecord::Base
  belongs_to :user
  validates :name, :description, presence: true
  validates :user_id, presence: true

  def uploaded_document=(document_field)
    self.name         = base_part_of(document_field.original_filename)
    self.content_type = document_field.content_type.chomp
    self.data         = document_field.read
  end

  def base_part_of(file_name)
#    File.basename(file_name).gsub(/[\A\w._-]/, '')
    File.basename(file_name)
  end
end
