#Pizza App

require "sinatra"
enable :sessions

get '/' do

  erb :select

end

post '/select' do

  session[:meats] = params[:meats]
  session[:veggies] = params[:veggies]
  session[:cheese] = params[:cheese]
  session[:size] = params[:size]
  session[:delivery] = params[:delivery]
  redirect '/confirm?'

end

get '/confirm' do

  erb :confirm, locals: {meats: session[:meats], veggies: session[:veggies]}

end
