class V1::AuthController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateGame.call(params[:code], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
