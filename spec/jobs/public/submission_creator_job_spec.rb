require 'rails_helper'

RSpec.describe Public::SubmissionCreatorJob, type: :job do
  include ActiveJob::TestHelper

  include_context "with Talent"
  include_context "with Recruiter::Job"

  describe "#perform_later" do
    let(:submission_valid_attributes) { { job_id: job.id, talent_id: talent.id } }
    it "creates Public::Job" do
      expect {
        perform_enqueued_jobs do
          described_class.perform_later(submission_valid_attributes)
        end
      }.to change(Public::Submission, :count).by(1)
    end
  end
end
