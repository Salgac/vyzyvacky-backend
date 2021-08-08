class ApplicationController < ActionController::API
  include ScoreHelper

  before_action :authenticate_request
  attr_reader :current_game

  private

  def authenticate_request
    @current_game = AuthorizeApiRequest.call(request.headers).result
    render json: { error: "Not authorized" }, status: 401 unless @current_game
  end
end
