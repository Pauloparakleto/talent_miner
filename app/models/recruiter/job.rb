class Recruiter::Job < ApplicationRecord
  belongs_to :recruiter

  validates_presence_of :title, :description, :status, :skills, :recruiter_id
end
