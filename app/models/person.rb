class Person < ApplicationRecord
  belongs_to :game
  belongs_to :team
  has_many :enties, foreign_key: :winner_id
  has_many :enties, foreign_key: :looser_id
end
