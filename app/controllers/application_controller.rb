class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActionController::ParameterMissing do |e|
    render json: {}, status: :bad_request
  end
end
