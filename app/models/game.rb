class Game < ApplicationRecord
  has_secure_password

  # validates game code
  validates :code, presence: true, uniqueness: true, format: { with: /\A#[A-Z0-9]{5}\z/, message: "Invalid game code" }
end
