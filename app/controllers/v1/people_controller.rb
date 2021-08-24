class V1::PeopleController < ApplicationController
  #GET v1/people
  def index
    render json: Person.joins(:team).where(game_id: @current_game.id).select(Person.column_names + Team.column_names - ["updated_at", "created_at", "team_id", "score"]).reorder("id ASC")
  end

  #POST v1/people
  def create
    json_arr = params[:_json]

    #Person.delete_all
    #ActiveRecord::Base.connection.reset_pk_sequence!("people")

    #add each item from json array into database
    json_arr.each do |person|
      firstName = person[:firstName]
      lastName = person[:lastName]
      team_id = Team.find_by(name: person[:team]).id
      game_id = @current_game.id
      age = person[:age]
      score = calculate_score(age)

      new_person = Person.new(:firstName => firstName, :lastName => lastName, :team_id => team_id, :game_id => game_id, :score => score, :age => age)
      new_person.save
    end

    render json: json_arr, status: 201
  end

  #DELETE v1/people/:id
  def destroy
    params.permit(:id)

    person = Person.where(game_id: @current_game.id).find_by_id(params[:id])
    person.destroy

    render status: 204
  end

  #GET v1/people/:id
  def show
    params.permit(:id)

    person = Person.where(game_id: @current_game.id).find_by_id(params[:id])

    preson.nil? ? (render status: 422) : (render json: person)
  end

  #PUT v1/people/:id
  def update
    params.permit(:id, :firstName, :lastName, :team)

    person = Person.where(game_id: @current_game.id).find_by_id(params[:id])

    firstName = params[:firstName]
    lastName = params[:lastName]
    team = params[:team]

    person.update(:firstName => firstName, :lastName => lastName, :team_id => Team.where(name: params[:team]).id)

    render json: person
  end
end
