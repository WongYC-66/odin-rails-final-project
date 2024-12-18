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
# names = [ "user1", "user2", "user3", "user4", "user5" ]
names = Array.new(10, "_")
  .map! do |name|
    Faker::Name.first_name().downcase
  end
puts names

# user
names.each do |name|
  user = User.new(
    username: name,
    email: "#{name}@example.com",
    password: "123456",
    password_confirmation: "123456"
  )
  user.save!
end

# profile
rand = Random.new(1234)
names.each do |name|
  user = User.find_by(username: name)
  user.profile.update({
    first_name: name,
    last_name: Faker::Name.last_name,
    description: "this is faker generated bio ... ",
    img_url: Faker::LoremFlickr.image(size: "75x75", search_terms: [ rand(1000) ])
  })
end

# new post
names.each do |name|
  user = User.find_by(username: name)
  user_new_post = user.posts.new({ contents: "Hi, im #{name.capitalize}. #{Faker::Lorem.sentence(word_count: 10)}. This is faker generated." })
  user_new_post.save!
end

# Guest account
guest = User.create(
  username: "guest",
  email: "guest@example.com",
  password: "123456",
  password_confirmation: "123456"
)

# guest follow everyones
names.each do |name|
  user = User.find_by(username: name)
  guest.followers << user
end
puts "guest"

puts "Completed seeding."
