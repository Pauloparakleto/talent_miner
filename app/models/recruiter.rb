class Recruiter < ApplicationRecord
  validates_presence_of :name, :email, :password
end
