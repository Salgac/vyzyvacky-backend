class AddGameToPeople < ActiveRecord::Migration[6.1]
  def change
    add_reference :people, :game, null: false, foreign_key: true
  end
end
