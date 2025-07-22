require 'rails_helper'

RSpec.describe "Api::V1::Drugs", type: :request do
  describe "GET /index" do
    let!(:drug) { create(:drug, name: "Aspirin") }

    it "returns an array of drugs" do
      get "/api/v1/drugs"
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response).to contain_exactly("id" => drug.id, "name" => "Aspirin")
    end
  end
end
