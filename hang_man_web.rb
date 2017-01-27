require_relative 'HangMan.rb'
require 'sinatra'
require "bundler/setup"

before do
  @game = HangMan.new("tree")
  @game.generate_board
end

get '/' do
  @board = @game.board
  @message = 'you have turns left'
  erb :index
end

post '/guess' do
  #@game = HangMan.new("tree")
  #@game.generate_board
  guess = params['guess']
  if @game.correct_guess(guess)
    @game.modify_board(guess)
    if @game.victory
      @game.print_board
      @message = "victory!"
      break
    end
  else
    @message =  "you have guesses left"
    counter -= 1
    if counter == 0
      @message =  "you lose!!!"
      break
    end
  end
  @board = @game.board

  @message = 'you have turns left'
  erb :index
end
