# require 'rails_helper'

shared_examples 'authenticated request' do
  describe "unauthenticated request" do
    let(:params) { {} }

    context "when API key is missing" do
      let(:headers) do
        {
          "ACCEPT" => "application/json",
          "Authorization" => ""
        }
      end

      it "returns unauthorized status" do
        send(verb, path, params: params, headers: headers)
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
        send(verb, path, params: params, headers: headers)
        expect(response).to have_http_status(:unauthorized)
        expect(json_response["error"]).to eq("Invalid API key")
      end
    end
  end
end
