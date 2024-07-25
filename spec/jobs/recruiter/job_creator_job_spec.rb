require 'rails_helper'

RSpec.describe Recruiter::JobCreatorJob, type: :job do
  include ActiveJob::TestHelper

  let(:recruiter) { Recruiter.create(recruiter_valid_attributes) }
  let(:recruiter_valid_attributes) {
    {
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: Faker::String.random(length: 7)
    }
  }

  let(:valid_attributes) {
    { title: Faker::Company.name, description: Faker::Company.catch_phrase,
      start_date: Faker::Date.forward(days: 7), end_date: Faker::Date.forward(days: 14),
      skills: ["ruby", "javascript"],
      status: 1, recruiter_id: recruiter.id
    }
  }

  it 'creates Recruiter::Job' do
    expect {
      perform_enqueued_jobs do
        described_class.perform_later(valid_attributes)
      end
    }.to change(Recruiter::Job, :count).by(1)
  end
end
