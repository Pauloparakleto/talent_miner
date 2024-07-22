require 'rails_helper'

RSpec.describe Recruiter::JobUpdaterJob, type: :job do
  include ActiveJob::TestHelper
  include_context 'with Recruiter::Job'
  let(:new_attributes) { { title: "New Title" } }

  it 'updates tittle' do
    perform_enqueued_jobs do
      described_class.perform_later(job.id, new_attributes)
    end

    expect(job.reload.title).to eq(new_attributes.fetch(:title))
  end
end
