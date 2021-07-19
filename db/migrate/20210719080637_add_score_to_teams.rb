class AddScoreToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :score, :integer
  end
end
