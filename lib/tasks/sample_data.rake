namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    #make_products
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.jp",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.jp"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_products
  29.times do |n|
    title  = "Product Title No.#{n+1}"
    description = Faker::Lorem.sentence(30)
    image_url = "DSC01162_#{n+1}.gif"
    Product.create!(title:       title,
                 description: description,
                 image_url:   image_url)
  end
end

