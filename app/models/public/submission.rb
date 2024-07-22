class Public::Submission < ApplicationRecord
  belongs_to :job, class_name: "Recruiter::Job"
  belongs_to :talent, class_name: "Talent"

  validates_presence_of :job_id, :talent_id
  validates :talent_id, uniqueness: { scope: :job_id }

  delegate :name, :email, :mobile_phone, :resume, to: :talent
end
