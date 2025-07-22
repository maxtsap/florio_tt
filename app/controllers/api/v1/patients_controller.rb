module Api
  module V1
    class PatientsController < ::Api::V1::BaseController
      def create
        patient = Patient.new(patient_params)

        if patient.save
          render json: { api_key: patient.api_key }, status: :created
        else
          render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def patient_params
        params.require(:patient).permit(:name)
      end
    end
  end
end
