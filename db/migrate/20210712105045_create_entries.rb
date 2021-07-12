class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.timestamp :time
      t.references :winner, null: false
      t.references :looser, null: false

      t.timestamps
    end
    add_foreign_key :entries, :people, column: :winner_id
    add_foreign_key :entries, :people, column: :looser_id
  end
end
