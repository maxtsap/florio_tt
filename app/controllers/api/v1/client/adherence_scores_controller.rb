module Api
  module V1
    module Client
      class AdherenceScoresController < Api::V1::Client::BaseController
        def show
          render json: { adherence_score: AdherenceScoreCalculator.new(current_patient).calculate }, status: :ok
        end
      end
    end
  end
end
