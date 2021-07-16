module ScoreHelper
  def calculate_score(age)
    return age >= 18 ? 2000 : 1500
  end
end
