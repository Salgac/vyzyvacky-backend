class V1::TeamsController < ApplicationController
  #GET v1/teams
  def index
    teams_arr = Team.where(game_id: @current_game.id).order("name ASC")
    json_arr = []

    for team in teams_arr
      json_arr.push({
        :id => team.id,
        :teamName => team.name,
        :teamColor => team.color,
      })
    end
    render json: json_arr
  end

  #POST v1/teams
  def create
    params.permit(:name, :color)

    name = params[:name]
    color = params[:color]
    game_id = @current_game.id

    new_team = Team.new(:name => name, :color => color, :game_id => game_id)
    new_team.save

    render json: new_team, status: 201
  end

  #DELETE v1/teams/:id
  def destroy
    params.permit(:id)

    team = Team.where(game_id: @current_game.id).find_by_id(params[:id])
    team.destroy

    render status: 204
  end

  #GET v1/teams/:id
  def show
    params.permit(:id)

    team = Team.where(game_id: @current_game.id).find_by_id(params[:id])

    team.nil? ? (render status: 422) : (render json: team)
  end

  #PUT v1/teams/:id
  def update
    params.permit(:id, :name, :color)

    team = Team.where(game_id: @current_game.id).find_by_id(params[:id])

    name = params[:name]
    color = params[:color]

    team.update(:name => name, :color => color)

    render json: team
  end
end
