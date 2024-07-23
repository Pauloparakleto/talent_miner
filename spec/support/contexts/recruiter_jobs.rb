require 'spec_helper'

shared_context 'with Recruiter::Job' do
  let!(:recruiter) { Recruiter.create(recruiter_valid_attributes) }
  let(:recruiter_valid_attributes) {
    {
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: Faker::String.random(length: 7)
    }
  }

  let(:job_valid_attributes) {
    { title: Faker::Company.name, description: Faker::Company.catch_phrase,
      start_date: Faker::Date.forward(days: 7), end_date: Faker::Date.forward(days: 14),
      skills: ["ruby", "javascript"],
      status: 1, recruiter_id: recruiter.id
    }
  }

  let!(:job) { Recruiter::Job.create(job_valid_attributes) }
end
