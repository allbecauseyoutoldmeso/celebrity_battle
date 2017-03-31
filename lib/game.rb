require_relative 'player'

class Game

  attr_reader :player_1, :player_2, :playing_now, :not_playing
  attr_writer :playing_now, :not_playing

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @playing_now = @player_1
    @not_playing = @player_2
  end

  def switch_turn
    if playing_now == player_1
      self.playing_now = player_2
      self.not_playing = player_1
    elsif playing_now == player_2
      self.playing_now = player_1
      self.not_playing = player_2
    end
  end

  def attack(player, option)
    player.got_attacked(option)
  end

  def restore_points(player, option)
    player.restore_points(option)
  end

  def player_name(player)
    player.name
  end

  def self.create(player_1, player_2)
  @game = Game.new(player_1, player_2)
end

def self.instance
  @game
end

end
