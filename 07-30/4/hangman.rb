require 'sinatra'
require 'pry'
require './hangman_class.rb'

enable :sessions

get '/' do
  if request["user_letter"]
    session[:game].guess_letter(request["user_letter"])
  else
    session[:game] = HangmanGame.new()
  end

  if session[:game].won?
    middle_area = %{<h3 style="color: green">You won!</h3>}
  elsif session[:game].lost?
    middle_area = %{<h3 style="color: red">You lost!</h3>}
  else
      middle_area = %{<form method="get" action="http://#{request.host}:#{request.port}/">
            Letter <input type="text" name="user_letter">
                   <input type="submit">
          </form>}
  end

  return %{<img src="#{session[:game].hangman_image_url()}"> <br><br>#{session[:game].word_display} <br><br> #{middle_area}<br><br> <h3>Missed Letters</h3> <br> #{session[:game].missed_word_display}}
end








