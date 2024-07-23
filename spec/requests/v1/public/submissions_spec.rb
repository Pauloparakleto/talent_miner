require 'rails_helper'

RSpec.describe 'v1/public/submissions', type: :request do
  include_context 'with Recruiter::Job'
  include_context 'with Talent'

  let(:valid_attributes) do
    {
      talent_id: talent.id,
      job_id: job.id
    }
  end

  let(:invalid_attributes) do
    {
      job_id: nil,
      talent_id: nil
    }
  end

  let(:valid_headers) { {} }

  describe 'GET /v1/public/submissions/' do
    include_context 'with Public::Submission'

    it 'renders a sucessfull response' do
      get v1_public_submissions_path, headers: valid_headers, as: :json
      byebug
      expect(response.status).to eq(200)
    end
  end
end
