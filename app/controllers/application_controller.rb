class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActionController::ParameterMissing do |e|
    render json: {}, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {}, status: :not_found
  end


end
