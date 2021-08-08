class AuthenticateGame
  prepend SimpleCommand

  def initialize(code, password)
    @code = code
    @password = password
  end

  def call
    JsonWebToken.encode(game_id: game.id) if game
  end

  private

  attr_accessor :code, :password

  def game
    game = Game.find_by(code: code)
    return game if game && game.authenticate(password)

    errors.add :user_authentication, "invalid credentials"
    nil
  end
end
