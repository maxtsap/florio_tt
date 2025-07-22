require 'rails_helper'

RSpec.describe "Api::V1::Patients", type: :request do
  describe "POST /api/v1/patients" do
    context "with valid parameters" do
      let(:valid_params) { { patient: { name: "John Doe" } } }

      it "creates a new patient and returns api_key" do
        expect { post "/api/v1/patients", params: valid_params }.to change(Patient, :count).by(1)
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response["api_key"]).not_to be_empty
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { { patient: { name: "" } } }

      it "does not create a new patient" do
        expect { post "/api/v1/patients", params: invalid_params }.to_not change(Patient, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to include("Name can't be blank")
      end
    end
  end
end
