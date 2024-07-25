class Public::SubmissionCreatorJob < ApplicationJob
  queue_as :default

  def perform(*attributes)
    Public::Submission.create!(attributes)
  end
end
