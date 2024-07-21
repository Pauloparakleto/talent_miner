puts "Module Recruiter"
10.times do |_number|
  Recruiter.create(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: Faker::String.random(length: 7)
  )
end
