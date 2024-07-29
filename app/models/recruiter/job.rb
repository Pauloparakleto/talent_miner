class Recruiter::Job < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_default, against: [:title, :description, :skills]

  paginates_per 100

  belongs_to :recruiter

  validates_presence_of :title, :description, :status, :skills, :recruiter_id
end
