class Entry < ApplicationRecord
  belongs_to :game
  belongs_to :winner, class_name: "Person"
  belongs_to :looser, class_name: "Person"
end
