class Recruiter::Job < ApplicationRecord
  paginates_per 100 

  belongs_to :recruiter

  validates_presence_of :title, :description, :status, :skills, :recruiter_id
end
