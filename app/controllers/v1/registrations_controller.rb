class V1::RegistrationsController < ApplicationController
  skip_before_action :authenticate_request

  def create
    new_game = Game.new(game_params)
    if new_game.save

      #login to game
      command = AuthenticateGame.call(params[:code], params[:password])
      command.success? ? token = command.result : return
      render json: { game_code: params[:code], auth_token: token }
    else
      render json: { error: "Game code " + params[:code] + " is already used." }
    end
  end

  private def game_params
    # strong parameters
    params.permit(:code, :password, :password_confirmation)
  end
end
