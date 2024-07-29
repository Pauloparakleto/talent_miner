puts "Module Recruiter"
10.times do |_number|
  Recruiter.create(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: Faker::String.random(length: 7)
  )
end

recruiter = Recruiter.last

puts "Module Recruiter::Job"

500.times do |_number|
  Recruiter::Job.create(
    { title: Faker::Company.name, description: Faker::Company.catch_phrase,
      start_date: Faker::Date.forward(days: 7), end_date: Faker::Date.forward(days: 14),
      skills: ["ruby", "javascript"],
      status: Recruiter::JobEnum::ACTIVE, recruiter_id: recruiter.id
    }
  )
end

puts "Module Talent"

500.times do |_number|
  Talent.create(name: Faker::Name.name, email: Faker::Internet.unique.email, mobile_phone: Faker::PhoneNumber.cell_phone)
end

puts "Public::Submission"

talent_ids = Talent.all.limit(120).pluck(:id)
job_ids = Recruiter::Job.all.limit(120).pluck(:id)
submission_attributes = []
talent_ids.each_with_index.map { |talent_id, index| submission_attributes << { talent_id: talent_id, job_id: job_ids[index]} }
Public::Submission.create(submission_attributes)
