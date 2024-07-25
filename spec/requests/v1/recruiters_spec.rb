require 'rails_helper'

RSpec.describe "/V1::Recruiters", type: :request do
  let(:valid_attributes) {
    {
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: Faker::Lorem.word
    }
  }

  let(:invalid_attributes) {
    {
      name: nil,
      email: Faker::Internet.unique.email,
      password: Faker::Lorem.word
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Recruiter.create! valid_attributes
      get v1_recruiters_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      recruiter = Recruiter.create! valid_attributes
      get v1_recruiter_url(recruiter), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Recruiter" do
        expect {
          post v1_recruiters_url,
               params: { recruiter: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Recruiter, :count).by(1)
      end

      it "renders a JSON response with the new recruiter" do
        post v1_recruiters_url,
             params: { recruiter: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Recruiter" do
        expect {
          post v1_recruiters_url,
               params: { recruiter: invalid_attributes }, as: :json
        }.to change(Recruiter, :count).by(0)
      end

      it "renders a JSON response with errors for the new recruiter" do
        post v1_recruiters_url,
             params: { recruiter: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_name) { 'New Name' }
      let(:new_attributes) {
        valid_attributes.merge(name: new_name)
      }

      it "updates the requested recruiter" do
        recruiter = Recruiter.create! valid_attributes
        patch v1_recruiter_url(recruiter),
              params: { recruiter: new_attributes }, headers: valid_headers, as: :json
        recruiter.reload
        expect(recruiter.name).to eq(new_name)
      end

      it "renders a JSON response with the recruiter" do
        recruiter = Recruiter.create! valid_attributes
        patch v1_recruiter_url(recruiter),
              params: { recruiter: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the recruiter" do
        recruiter = Recruiter.create! valid_attributes
        patch v1_recruiter_url(recruiter),
              params: { recruiter: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested recruiter" do
      recruiter = Recruiter.create! valid_attributes
      expect {
        delete v1_recruiter_url(recruiter), headers: valid_headers, as: :json
      }.to change(Recruiter, :count).by(-1)
    end
  end
end
