require 'rails_helper'

RSpec.describe Public::Submission, type: :model do
  describe "db columns" do
    it { should have_db_column(:job_id).of_type(:integer) }
    it { should have_db_column(:talent_id).of_type(:integer) }
  end

  describe "validations" do
    it { should validate_presence_of(:job_id) }
    it { should validate_presence_of(:talent_id) }
    it { should validate_uniqueness_of(:talent_id).scoped_to(:job_id) }
  end

  describe "delegations" do
    it { should delegate_method(:name).to(:talent) }
    it { should delegate_method(:email).to(:talent) }
    it { should delegate_method(:mobile_phone).to(:talent) }
    it { should delegate_method(:resume).to(:talent) }
  end
end
