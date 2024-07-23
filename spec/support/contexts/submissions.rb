require 'spec_helper'

shared_context 'with Public::Submission' do
  include_context 'with Recruiter::Job'
  include_context 'with Talent'

  let(:valid_attributes) do
    {
      talent_id: talent.id,
      job_id: job.id
    }
  end

  let!(:submission) do
    Public::Submission.create(valid_attributes)
  end
end
