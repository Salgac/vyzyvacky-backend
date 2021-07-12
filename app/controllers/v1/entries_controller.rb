class V1::EntriesController < ApplicationController
  #GET v1/entries
  def index
    render json: Entry.all
  end

  #POST v1/entries
  def create
    params.permit(:time, :winner, :looser)

    time = params[:time]
    winner = params[:winner]
    looser = params[:looser]

    new_entry = Entry.new(:time => time, :winner_id => winner, :looser_id => looser)
    new_entry.save

    render json: new_entry, status: 201
  end

  #DELETE v1/entries/:id
  def destroy
    params.permit(:id)

    entry = Entry.find_by_id(params[:id])
    entry.destroy

    render status: 204
  end
end
