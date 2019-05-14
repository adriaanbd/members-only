# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n| 
  name = Faker::Name.name
  email = "test_#{n+1}@example.com"
  password = 'secret'
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end

10.times do |n| 
  title = "Lorem Ipsum No.#{n+1}"
  body = "Sint temporibus quis tenetur quaerat officia est et. Aut corporis eum explicabo ab illo consectetur suscipit ut. Illo voluptatibus atque itaque. Voluptatem est et labore explicabo aperiam et eum"
  user_id = User.first.id
  Post.create!(
    title: title,
    body: body,
    user_id: user_id
  )
end
