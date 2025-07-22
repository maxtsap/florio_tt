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

  it_behaves_like 'authenticated request' do
    let(:verb) { :get }
    let(:path) { '/api/v1/client/adherence_score' }
  end
end
