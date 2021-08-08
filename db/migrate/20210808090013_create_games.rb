class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :code, null: false
      t.string :password_digest

      t.timestamps
    end
  end
end
