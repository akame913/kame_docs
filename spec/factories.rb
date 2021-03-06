# encoding: utf-8

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:group) { |n| "Group-#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
  
  factory :product do
    sequence(:title)       { |n| "Title #{n}" }
    sequence(:description) { |n| "Product_#{n} description"} 
    sequence(:image_url)   { |n| "image_#{n}.gif"}
  end    

  factory :document do
    sequence(:name)         { |n| "Name #{n}" }
    sequence(:group)        { |n| "group-#{n}" }
    group_dl_allow  true
    other_dl_allow  true
    sequence(:description)  { |n| "Document_#{n} description"} 
    sequence(:data)         { |n| "data image document_#{n}"}
    sequence(:content_type) { |n| "text/txt"}
    user_id 1
    #name          "Name"
    #description   "Document description" 
    #data          "data document"
    #content_type  "text/txt"
    #user_id 1
  end    

  factory :picture do
    sequence(:comment)      { |n| "comment #{n}" }
    sequence(:name)         { |n| "test_#{n}.gif"} 
    sequence(:data)         { |n| "data image test_#{n}"}
    sequence(:content_type) { |n| "image/gif"}
    #comment       "This is comment"
    #name          "test-image.gif"
    #data          "1234567890abcdefg"
    #NG data          File.open(File.join(Rails.root, 'spec/fixture/test-image.gif'))
    #NG data {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixture', 'test-image.gif')) }
    #NG data  {fixture_file_upload([Rails.root, 'spec', 'fixture', 'test-image.gif'].join("/"), "image/gif")} 
    #NG data { fixture_file_upload("#{Rails.root}/spec/fixture/test-image.gif", "image/gif") }
    #content_type  'image/gif'
  end    
end
