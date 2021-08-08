class V1::RegistrationsController < ApplicationController
  def create
    new_game = Game.new(game_params)
    if new_game.save
      render json: new_game
    else
      render json: { error: "Game code " + params[:code] + " is already used." }
    end
  end

  private def game_params
    # strong parameters
    params.permit(:code, :password, :password_confirmation)
  end
end
