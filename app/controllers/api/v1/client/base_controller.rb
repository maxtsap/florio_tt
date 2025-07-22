module Api
  module V1
    module Client
      class BaseController < Api::V1::BaseController
        before_action :authenticate_patient!

        private

        attr_reader :current_patient

        def authenticate_patient!
          api_key = request.headers['Authorization']

          if api_key.blank?
            render json: { error: 'API key is missing' }, status: :unauthorized
            return
          end

          @current_patient = ::Patient.find_by(api_key: api_key)

          render json: { error: 'Invalid API key' }, status: :unauthorized unless @current_patient
        end
      end
    end
  end
end
