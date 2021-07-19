class V1::ScoreboardController < ApplicationController
  def index
    people_arr = Person.joins(:team).select(Person.column_names + Team.column_names - ["updated_at", "created_at"])
    entry_arr = Entry.all.reorder("time ASC")

    reset_score(people_arr)

    entry_arr.each do |entry|
      #select participants
      winner = Person.find_by_id(entry.winner_id)
      looser = Person.find_by_id(entry.looser_id)

      #calculate constant
      if winner.score < 2100
        k = 32
      elsif winner.score < 2400
        k = 24
      else
        k = 16
      end

      #calculate score
      winner_we = 1.0 / ((10 ** (-(winner.score - looser.score) / 400.0)) + 1)
      looser_we = 1.0 / ((10 ** (-(looser.score - winner.score) / 400.0)) + 1)

      winner_new = winner.score + k * (1 - winner_we)
      looser_new = looser.score + k * (0 - looser_we)

      #set new score
      winner.update(score: winner_new)
      looser.update(score: looser_new)
    end

    render json: people_arr.reorder("score DESC").order("id ASC")
  end

  #helper
  def reset_score(arr)
    arr.each do |person|
      person.update(score: calculate_score(person.age))
    end
  end
end