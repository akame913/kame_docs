namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_documents
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       group:     "group-1",
                       email:     "example@railstutorial.jp",
                       password:  "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  5.times do |n|
    name  = Faker::Name.name
    group = "group-#{n+1}"
    email = "example-#{n+1}@railstutorial.jp"
    password  = "password"
    User.create!(name:     name,
                 group:    group,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_documents
  5.times do |n|
    name  = "document-#{n+1}.txt"
    user_id = n+1
    group = "group-#{n+1}"
    description = "Group#{n+1} sample document"
    data = "This is text file-No.#{n+1}."
    content_type = "text/plain" 
    Document.create!(name:          name,
                     user_id:        user_id,
                     group:          group,
                     group_dl_allow: true,
                     description:    description,
                     data:           data,
                     content_type:   content_type)
  end
end
