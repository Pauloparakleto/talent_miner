require 'rails_helper'

RSpec.describe Talent, type: :model do
  describe "db columns" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:mobile_phone).of_type(:string) }
  end

  describe "associations" do
    it { should have_many(:submissions).class_name("Public::Submission").dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:mobile_phone) }
  end

  describe "attached resume" do
    it { should have_one_attached(:resume) }
  end
end
