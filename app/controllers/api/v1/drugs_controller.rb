module Api
  module V1
    class DrugsController < Api::V1::BaseController
      def index
        render json: Drug.all.to_json(only: %i[id name]), status: :ok
      end
    end
  end
end
