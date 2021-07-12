class V1::PeopleController < ApplicationController
  #GET v1/people
  def index
    render json: Person.all
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
      age = person[:age]
      age >= 18 ? score = 2000 : score = 1500

      new_person = Person.new(:firstName => firstName, :lastName => lastName, :team_id => team_id, :score => score)
      new_person.save
    end

    render json: json_arr, status: 201
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
