# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Starting to seed ...."
names = [ "user1", "user2", "user3", "user4", "user5" ]

names.each do |name|
  user = User.new
  user = User.new(
    username: name,
    email: "#{name}@example.com",
    password: "123456",
    password_confirmation: "123456"
  )
  user.save!
end

names.each do |name|
  user = User.find_by(username: name)
  user_new_post = user.posts.new({ contents: "Hi, im #{name}" })
  user_new_post.save!
end

puts "Completed seeding."
