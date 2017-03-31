require 'sinatra/base'
require_relative './lib/game'
require_relative './lib/robot'

class Battle < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/names' do
    @player_1 = Player.new(params[:player_1_name])
    @player_2 = Player.new(params[:player_2_name])
    @game = Game.create(@player_1, @player_2)
    redirect '/play'
  end

  get '/play' do
    @game = Game.instance
    @playing_now_name = @game.player_name(@game.playing_now)
    @not_playing_name = @game.player_name(@game.not_playing)
    @playing_now_fame_points = @game.playing_now.fp
    @not_playing_fame_points = @game.not_playing.fp
    erb :play
  end

  post '/attack' do
    @game = Game.instance
    @playing_now = @game.playing_now
    @not_playing = @game.not_playing
    $playing_now_attack = params[:playing_now_attack]
    if $playing_now_attack != "is filled with rage as you restore your celebrity status by adopting a village of African children"
      @game.attack(@not_playing, $playing_now_attack)
    else
      @game.restore_points(@playing_now, $playing_now_attack)
    end
    if @game.not_playing.fp <= 0
      redirect '/win'
    elsif @not_playing.is_a?(Robot)
      redirect '/lonely_fight'
    else
      redirect '/fight'
    end
  end

  get '/fight' do
    @game = Game.instance
    @playing_now_name = @game.player_name(@game.playing_now)
    @not_playing_name = @game.player_name(@game.not_playing)
    @playing_now_fame_points = @game.playing_now.fp
    @not_playing_fame_points = @game.not_playing.fp
    erb :fight
  end

  get '/switch' do
    @game = Game.instance
    @game.switch_turn
    redirect '/play'
  end

  get '/win' do
    @game = Game.instance
    @playing_now_name = @game.player_name(@game.playing_now)
    @not_playing_name = @game.player_name(@game.not_playing)
    erb :win
  end


################################################################
################################################################
################################################################
################################################################
################################################################ 1 player game

  post '/lonely_names' do
    @player_1 = Player.new(params[:lonely_player])
    @player_2 = Robot.new('Mandy Dingle')
    @game = Game.create(@player_1, @player_2)
    redirect '/play'
  end

  # get '/lonely_play' do
  #   @game = Game.instance
  #   @player_1_name = @game.player_name(@game.player_1)
  #   @player_2_name = @game.player_name(@game.player_2)
  #   @player_2_fame_points = @game.player_2.fp
  #   @player_1_fame_points = @game.player_1.fp
  #   erb :lonely_play
  # end

  # post '/lonely_attack' do
  #   @game = Game.instance
  #   @player_1 = @game.player_1
  #   @player_2 = @game.player_2
  #   $player_1_attack = params[:player_1_attack]
  #   if $player_1_attack != "is filled with rage as you restore your celebrity status by adopting a village of African children"
  #     @game.attack(@player_2, $player_1_attack)
  #   else
  #     @game.restore_points(@player_1, $player_1_attack)
  #   end
  #   if @game.player_2.fp <= 0
  #     redirect '/lonely_win'
  #   else
  #     redirect '/lonely_fight'
  #   end
  # end

  get '/lonely_fight' do
    @game = Game.instance
    @playing_now_name = @game.player_name(@game.playing_now)
    @not_playing_name = @game.player_name(@game.not_playing)
    @playing_now_fame_points = @game.playing_now.fp
    @not_playing_fame_points = @game.not_playing.fp
    erb :lonely_fight
  end

  get '/lonely_fight2' do
    @game = Game.instance
    @player_1_name = @game.player_name(@game.player_1)
    @player_2_name = @game.player_name(@game.player_2)
    @player_2_fame_points = @game.player_2.fp
    @player_1_fame_points = @game.player_1.fp
    @player_1 = @game.player_1
    @player_2 = @game.player_2
    @option = @player_1.computer_attack
    @game.attack(@player_1, @option)
    if @game.player_2.fp <= 0
      redirect '/lonely_win'
    else
      erb :lonely_fight2
    end
  end


    # start the server if ruby file executed directly
    run! if app_file == $0

end
