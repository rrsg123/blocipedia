require 'faker'


10.times do
  user = User.new(
    name:      Faker::Name.name,
    email:     Faker::Internet.email,
    password: 'blocpass'
    )
  
  user.save!
end

admin = User.new(
  name:       'Admin User',
  email:      'admin@example.com',
  password:   'blocpass',
  role:       'admin'
  ) 

admin.save!

premium = User.new(
  name:       'Premium User',
  email:      'premium@example.com',
  password:   'blocpass',
  role:       'premium'
  )

premium.save!


member = User.new(
  name:       'Member User',
  email:      'member@example.com',
  password:   'blocpass',
  )

member.save!

users = User.all

puts "#{User.count} users created."

users.each do |user|
  user.wikis.create!(
    title:    Faker::Lorem.word,
    body:     Faker::Lorem.paragraph,
    private:  false
  )
end

Wikis = Wiki.all

puts "#{Wiki.count} posts created"

puts "Seed finished"