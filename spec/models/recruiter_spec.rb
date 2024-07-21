require 'rails_helper'

RSpec.describe Recruiter, type: :model do
  describe "columns" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:password).of_type(:string) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end


  describe "db column index" do
    it { should have_db_index(:email) }
  end
end
