class Talent < ApplicationRecord
  paginates_per 100

  has_one_attached :resume
  has_many :submissions, class_name: "Public::Submission", dependent: :destroy

  validates_presence_of :name, :mobile_phone, :email
  validates :email, :mobile_phone, uniqueness: true
end
