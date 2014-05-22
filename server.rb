require_relative '2048'
require 'sinatra'

set :public_folder, File.dirname(__FILE__) + '/public'
set :views, File.dirname(__FILE__) + '/views'


game_board = [[" ", " ", " ", " "],
              [" ", " ", " ", " "],
              [" ", " ", " ", " "],
              [" ", " ", " ", " "]]

new_board = insert_new(game_board)




get '/' do
  @board = new_board
  erb :index
# end get do
end
