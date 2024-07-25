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

  describe 'GET /index' do
    include_context 'with Public::Submission'

    it 'renders a sucessfull response' do
      get v1_public_submissions_path, headers: valid_headers, as: :json
      expect(response.status).to eq(200)
    end
  end

  describe "GET /show" do
    include_context 'with Public::Submission'

    it "renders a successful response" do
      get v1_public_submission_path(submission), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Public::Submission" do
        expect {
          perform_enqueued_jobs do
            post v1_public_submissions_path,
               params: { submission: valid_attributes }, headers: valid_headers, as: :json
          end
        }.to change(Public::Submission, :count).by(1)
      end

      it "renders a JSON response with the new submission" do
        post v1_public_submissions_path,
             params: { submission: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Public::Submission" do
        expect {
          post v1_public_submissions_path,
               params: { submission: invalid_attributes }, as: :json
        }.to change(Public::Submission, :count).by(0)
      end

      it "renders a JSON response with errors for the new submission" do
        post v1_public_submissions_path,
             params: { submission: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    include_context 'with Public::Submission'

    it "destroys the requested Submission" do
      expect {
        delete v1_public_submission_path(submission), headers: valid_headers, as: :json
      }.to change(Public::Submission, :count).by(-1)
    end
  end
end
