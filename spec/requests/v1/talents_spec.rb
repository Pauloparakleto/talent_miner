require 'rails_helper'

RSpec.describe "/talent/", type: :request do
  include ActiveJob::TestHelper

  let(:talent) { Talent.create(valid_attributes) }
  let(:valid_attributes) {
    {
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      mobile_phone: Faker::PhoneNumber.unique.cell_phone
    }
  }

  let(:invalid_attributes) {
    {
      name: nil,
      email: Faker::Internet.unique.email,
      mobile_phone: Faker::PhoneNumber.cell_phone
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      get v1_talents_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get v1_talent_url(talent), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new talent" do
        expect {
          perform_enqueued_jobs do
            post v1_talents_url,
               params: { talent: valid_attributes }, headers: valid_headers, as: :json
          end
        }.to change(Talent, :count).by(1)
      end

      it "renders a JSON response with the new talent_talent" do
        post v1_talents_url,
             params: { talent: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new talent" do
        expect {
          post v1_talents_url,
               params: { talent: invalid_attributes }, as: :json
        }.to change(Talent, :count).by(0)
      end

      it "renders a JSON response with errors for the new talent_talent" do
        post v1_talents_url,
             params: { talent: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: "New Name" }
      }

      it "updates the requested talent" do
        talent = Talent.create! valid_attributes
        perform_enqueued_jobs do
          patch v1_talent_url(talent),
                params: { talent: new_attributes }, headers: valid_headers, as: :json
        end
        talent.reload
        expect(talent.name).to eq(new_attributes.fetch(:name))
      end

      it "renders a JSON response with the talent" do
        talent = Talent.create! valid_attributes
        patch v1_talent_url(talent),
              params: { talent: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the talent_talent" do
        talent = Talent.create! valid_attributes
        patch v1_talent_url(talent),
              params: { talent: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested talent_talent" do
      talent = Talent.create! valid_attributes
      expect {
        delete v1_talent_url(talent), headers: valid_headers, as: :json
      }.to change(Talent, :count).by(-1)
    end
  end
end
