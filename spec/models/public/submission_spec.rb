require 'rails_helper'

RSpec.describe Public::Submission, type: :model do
  describe "db columns" do
    it { should have_db_column(:job_id).of_type(:integer) }
    it { should have_db_column(:talent_id).of_type(:integer) }
  end

  describe "validations" do
    it { should validate_presence_of(:job_id) }
    it { should validate_presence_of(:talent_id) }
  end

  describe "delegations" do
    it { should delegate_method(:name).to(:talent) }
    it { should delegate_method(:email).to(:talent) }
    it { should delegate_method(:mobile_phone).to(:talent) }
    it { should delegate_method(:resume).to(:talent) }
  end

  context "when diferent person submit to the same job" do
    include_context "with Recruiter::Job"
    let(:talent) do
      Talent.create(name: Faker::Name.name, email: Faker::Internet.email, phone_number: Faker::PhoneNumber.cell_phone)
    end
    let(:talent_2) do
      Talent.create(name: Faker::Name.name, email: Faker::Internet.email, phone_number: Faker::PhoneNumber.cell_phone)
    end

    let(:submission) { Public::Submission.create(job_id: job.id, talent_id: talent.id) }

    it "is valid" do
      submission = Public::Submission.build(job_id: job.id, talent_id: talent_2.id)

      expect(submission.valid?).to eq(true)
    end
  end


  context "when same person submit to the same job twice" do
    include_context "with Recruiter::Job"
    let(:talent) do
      Talent.create(name: Faker::Name.name, email: Faker::Internet.email, phone_number: Faker::PhoneNumber.cell_phone)
    end
    let(:submission) { Public::Submission.create(job_id: job.id, talent_id: talent.id) }

    it "is invalid" do
      submission = Public::Submission.build(job_id: job.id, talent_id: talent.id)

      expect(submission.valid?).to eq(false)
    end
  end
end
