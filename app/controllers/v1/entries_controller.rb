class V1::EntriesController < ApplicationController
  #GET v1/entries
  def index
    render json: Entry.all
  end

  #POST v1/entries
  def create
    json_arr = params[:_json]

    #add each item from json array into database
    json_arr.each do |entry|
      time = entry[:time]
      winner = entry[:winner]
      looser = entry[:looser]

      entry = Entry.new(:time => time, :winner_id => winner, :looser_id => looser)
      entry.save!
    end

    render json: json_arr, status: 201
  end

  #DELETE v1/entries/:id
  def destroy
    params.permit(:id)

    entry = Entry.find_by_id(params[:id])
    entry.destroy

    render status: 204
  end
end
