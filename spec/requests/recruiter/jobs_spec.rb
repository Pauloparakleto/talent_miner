require 'rails_helper'

RSpec.describe "/recruiter/jobs", type: :request do
  include ActiveJob::TestHelper

  let!(:recruiter) { Recruiter.create(recruiter_valid_attributes) }
  let(:recruiter_valid_attributes) {
    {
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: Faker::String.random(length: 7)
    }
  }

  let(:valid_attributes) {
    { title: Faker::Company.name, description: Faker::Company.catch_phrase,
      start_date: Faker::Date.forward(days: 7), end_date: Faker::Date.forward(days: 14),
      skills: ["ruby", "javascript"],
      status: 1, recruiter_id: recruiter.id
    }
  }

  let(:invalid_attributes) {
    { title: nil, description: Faker::Company.catch_phrase,
      start_date: Faker::Date.forward(days: 7), end_date: Faker::Date.forward(days: 14),
      status: 1
    }

  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Recruiter::Job.create! valid_attributes
      get v1_recruiter_jobs_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      job = Recruiter::Job.create! valid_attributes
      get v1_recruiter_job_url(job), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Recruiter::Job" do
        expect {
          perform_enqueued_jobs do
            post v1_recruiter_jobs_url,
               params: { recruiter_job: valid_attributes }, headers: valid_headers, as: :json
          end
        }.to change(Recruiter::Job, :count).by(1)
      end

      it "renders a JSON response with the new recruiter_job" do
        post v1_recruiter_jobs_url,
             params: { recruiter_job: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Recruiter::Job" do
        expect {
          post v1_recruiter_jobs_url,
               params: { recruiter_job: invalid_attributes }, as: :json
        }.to change(Recruiter::Job, :count).by(0)
      end

      it "renders a JSON response with errors for the new recruiter_job" do
        post v1_recruiter_jobs_url,
             params: { recruiter_job: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { title: "New Title" }
      }

      it "updates the requested recruiter_job" do
        job = Recruiter::Job.create! valid_attributes
        patch v1_recruiter_job_url(job),
              params: { recruiter_job: new_attributes }, headers: valid_headers, as: :json
        job.reload
        expect(job.title).to eq(new_attributes.fetch(:title))
      end

      it "renders a JSON response with the recruiter_job" do
        job = Recruiter::Job.create! valid_attributes
        patch v1_recruiter_job_url(job),
              params: { recruiter_job: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the recruiter_job" do
        job = Recruiter::Job.create! valid_attributes
        patch v1_recruiter_job_url(job),
              params: { recruiter_job: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested recruiter_job" do
      job = Recruiter::Job.create! valid_attributes
      expect {
        delete v1_recruiter_job_url(job), headers: valid_headers, as: :json
      }.to change(Recruiter::Job, :count).by(-1)
    end
  end
end
