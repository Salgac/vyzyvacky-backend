class V1::PeopleController < ApplicationController
  #GET v1/people
  def index
    render json: Person.all
  end

  #POST v1/people
  def create
    params.permit(:firstName, :lastName, :team)

    firstName = params[:firstName]
    lastName = params[:lastName]
    team = params[:team]
    score = 1500

    new_person = Person.new(:firstName => firstName, :lastName => lastName, :team_id => Team.where(name: params[:team]).ids.first, :score => score)
    new_person.save

    render json: new_person, status: 201
  end

  #DELETE v1/people/:id
  def destroy
    params.permit(:id)

    person = Person.find_by_id(params[:id])
    person.destroy

    render status: 204
  end

  #GET v1/people/:id
  def show
    params.permit(:id)

    person = Person.find_by_id(params[:id])

    preson.nil? ? (render status: 422) : (render json: person)
  end

  #PUT v1/people/:id
  def update
    params.permit(:id, :firstName, :lastName, :team)

    person = Person.find_by_id(params[:id])

    firstName = params[:firstName]
    lastName = params[:lastName]
    team = params[:team]

    person.update(:firstName => firstName, :lastName => lastName, :team_id => Team.where(name: params[:team]).id)

    render json: person
  end
end
