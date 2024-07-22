class Recruiter::JobUpdaterJob < ApplicationJob
  queue_as :default

  def perform(job_id, new_attributes)
    Recruiter::Job.find(job_id).update(new_attributes)
  end
end
