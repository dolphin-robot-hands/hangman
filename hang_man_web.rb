require_relative 'HangMan.rb'
require 'sinatra'
require "bundler/setup"

configure do
  enable :sessions
  set :session_secret, "secret"
end

get '/' do
  @session = session
  word = "tree"
  game = HangMan.new(word)
  game.generate_board
  session["counter"] = 6
  session["word"] = word
  session["board"] = game.board
  @board = session["board"]
  @message = 'you have 6 turns left'
  erb :index
end

post '/guess' do
  board = session["board"]
  #puts ">>>>>>>>>>>>>> #{board}<<<<<<<<<<<<<<<<<<<<<<<<"
  word = session["word"]
  counter = session["counter"]

  guess = params['guess']

  game = HangMan.new(word)
  game.generate_board
  if game.correct_guess(guess, word)
    board = game.modify_board(guess, word, board)
    message = "you have #{counter} guesses left"
    if game.victory(word, board)
      board = board
      message = "victory!"
    end
  else
    counter -= 1
    message =  "you have #{counter} guesses left"

    session["counter"] = counter
    if counter == 0
      message =  "you lose!!!"
      puts ">>>>>>>>>>>>>> #{counter}<<<<<<<<<<<<<<<<<<<<<<<<"
    end
  end
  @board = board
  @message = message
  erb :index
end
