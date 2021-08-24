class AddGameToEntries < ActiveRecord::Migration[6.1]
  def change
    add_reference :entries, :game, null: false, foreign_key: true
  end
end
