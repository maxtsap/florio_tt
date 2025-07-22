module Api
  module V1
    module Client
      class InjectionsController < Api::V1::Client::BaseController
        def index
          render json: current_patient.injections.to_json, status: :ok
        end

        def create
          injection = current_patient.injections.new(injection_params)

          if injection.save
            render json: injection.to_json, status: :created
          else
            render json: { errors: injection.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def injection_params
          params.require(:injection).permit(:lot_number, :dose, :drug_id)
        end
      end
    end
  end
end
