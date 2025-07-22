require 'rails_helper'

RSpec.describe "Api::V1::Client::Injections", type: :request do
  let(:patient) { create(:patient) }
  let(:json_response) { JSON.parse(response.body) }

  describe "GET /api/v1/client/injections" do
    let!(:injection) { create(:injection, dose: 10, lot_number: "ABC123", patient: patient, drug: drug) }
    let(:drug) { create(:drug) }

    context "with valid parameters" do
      let(:headers) do
        {
          "ACCEPT" => "application/json",
          "Authorization" => patient.api_key
        }
      end

      it "creates a new Injection and returns json" do
        get '/api/v1/client/injections', headers: headers
        expect(response).to have_http_status(:ok)
        expect(json_response[0]).to include(
          "dose" => 10,
          "drug_id" => drug.id,
          "lot_number" => "ABC123"
        )
      end
    end
  end

  describe "POST /api/v1/client/injections" do
    let(:drug) { create(:drug) }
    let(:valid_attributes) do
      {
        injection: {
          dose: 10,
          drug_id: drug.id,
          lot_number: "ABC123"
        }
      }
    end
    let(:invalid_attributes) do
      {
        injection: {
          dose: 0,
          drug_id: drug.id,
          lot_number: "ABC"
        }
      }
    end
    let(:headers) do
      {
        "ACCEPT" => "application/json",
        "Authorization" => patient.api_key
      }
    end

    context "with valid parameters" do
      it "creates a new Injection and returns json" do
        expect { post '/api/v1/client/injections', params: valid_attributes, headers: headers }
          .to change(patient.injections, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(json_response).to include(
          "dose" => 10,
          "drug_id" => drug.id,
          "lot_number" => "ABC123"
        )
      end
    end

    context "with invalid parameters" do
      it "does not create a new Injection" do
        expect { post '/api/v1/client/injections', params: invalid_attributes, headers: headers }
          .to change(Injection, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response["errors"]).to include(
          "Dose must be greater than 0",
          "Lot number is the wrong length (should be 6 characters)"
        )
      end

      it "returns validation errors" do
        post '/api/v1/client/injections', params: invalid_attributes, headers: headers
        expect(json_response["errors"]).to include(
          "Dose must be greater than 0",
          "Lot number is the wrong length (should be 6 characters)"
        )
      end
    end

    describe "unauthenticated request" do
      context "when API key is missing" do
        let(:headers) do
          {
            "ACCEPT" => "application/json",
            "Authorization" => ""
          }
        end

        it "returns unauthorized status" do
          post '/api/v1/client/injections', params: valid_attributes, headers: headers
          expect(response).to have_http_status(:unauthorized)
          expect(json_response["error"]).to eq("API key is missing")
        end
      end

      context "when API key is invalid" do
        let(:headers) do
          {
            "ACCEPT" => "application/json",
            "Authorization" => "invalid_api_key"
          }
        end

        it "returns unauthorized status" do
          post '/api/v1/client/injections', params: valid_attributes, headers: headers
          expect(response).to have_http_status(:unauthorized)
          expect(json_response["error"]).to eq("Invalid API key")
        end
      end
    end
  end
end
