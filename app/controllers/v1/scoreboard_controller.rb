class V1::ScoreboardController < ApplicationController
  def index
    reset_score(Person.where(game_id: @current_game.id))

    entry_arr = Entry.where(game_id: @current_game.id).reorder("time ASC")
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

    #add all person data into response array
    people_arr = Person.joins(:team).where(game_id: @current_game.id).reorder("score DESC").order("people.\"lastName\" ASC").all
    json_arr = []

    people_arr.each do |person|
      json_arr.push({
        :id => person.id,
        :firstName => person.firstName,
        :lastName => person.lastName,
        :score => person.score,
        :teamName => person.team.name,
        :teamColor => person.team.color,
      })
    end

    render json: json_arr
  end

  def team
    team_arr = Team.where(game_id: @current_game.id)
    json_arr = []

    team_arr.each do |team|
      people = Person.where(game_id: @current_game.id, team_id: team.id)

      score = 0
      count = 0

      people.each do |person|
        pScore = person.score

        #ignore people with 2000 score by default
        if (calculate_score(person.age) == 2000)
          pScore -= 500
        end

        score += pScore
        count += 1
      end

      #average the score
      count != 0 ? score = score / count : nil

      #update and push
      team.update(score: (score))

      json_arr.push({
        :id => team.id,
        :teamName => team.name,
        :teamColor => team.color,
        :score => team.score,
      })
    end

    render json: json_arr.sort_by { |obj| obj[:score] }.reverse
  end

  #helper
  def reset_score(arr)
    arr.each do |person|
      person.update(score: calculate_score(person.age))
    end
  end
end
