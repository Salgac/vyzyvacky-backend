class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :firstName
      t.string :lastName
      t.integer :score
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
