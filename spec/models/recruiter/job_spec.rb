require 'rails_helper'

RSpec.describe Recruiter::Job, type: :model do
  describe "columns" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:string) }
    it { should have_db_column(:start_date).of_type(:date) }
    it { should have_db_column(:end_date).of_type(:date) }
    it { should have_db_column(:status).of_type(:integer) }
    it { should have_db_column(:skills).of_type(:jsonb) }
    it { should have_db_column(:recruiter_id).of_type(:integer) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:skills) }
    it { should validate_presence_of(:recruiter_id) }
  end


  describe "db column index" do
    it { should have_db_index(:status) }
  end
end
