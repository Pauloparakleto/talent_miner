class Recruiter::JobCreatorJob < ApplicationJob
  queue_as :default

  def perform(attributes)
    Recruiter::Job.create(attributes)
  end
end
