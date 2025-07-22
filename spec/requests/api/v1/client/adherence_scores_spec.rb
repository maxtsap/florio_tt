require 'rails_helper'

RSpec.describe "Api::V1::Client::AdherenceScores", type: :request do
  let(:patient) { create(:patient) }
  let(:json_response) { JSON.parse(response.body) }

  describe "GET /show" do
    let(:headers) do
      {
        "ACCEPT" => "application/json",
        "Authorization" => patient.api_key
      }
    end

    before do
      allow_any_instance_of(AdherenceScoreCalculator).to receive(:calculate).and_return(85)
    end

    it "returns http success" do
      get "/api/v1/client/adherence_score", headers: headers
      expect(response).to have_http_status(:ok)
      expect(json_response).to eq("adherence_score" => 85)
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
        get '/api/v1/client/adherence_score', headers: headers
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
        get '/api/v1/client/adherence_score', headers: headers
        expect(response).to have_http_status(:unauthorized)
        expect(json_response["error"]).to eq("Invalid API key")
      end
    end
  end
end
