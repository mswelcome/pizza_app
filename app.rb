#Pizza App

require "sinatra"
enable :sessions

@cost = 0

get '/' do

  erb :select

end

post '/select' do

  session[:meats] = params[:meats]
  session[:veggies] = params[:veggies]
  session[:cheese] = params[:cheese]
  session[:size] = params[:size]
  session[:delivery] = params[:delivery]
  if size == "extralarge"
    @cost = @cost + 15
  elsif size == "large"
    @cost = @cost + 12
  elsif size == "medium"
    @cost = @cost + 9
  else size == "small"
    @cost = @cost + 7
  end
  redirect '/confirm?'

end

get '/confirm' do

  erb :confirm, locals: {meats: session[:meats], veggies: session[:veggies], cheese: session[:cheese], size: session[:size], delivery: session[:delivery]}

end

post '/res' do

  session[:address] = params[:address]
  session[:conf] = params[:conf].to_a
  redirect '/results?'

end

get '/more' do
    session[:pizzas] = params[:pizzas]
    erb :more, locals: {conf: session[:conf], address: session[:address], size: session[:size]}

end

get 'results' do

    erb :results, locals: {}
end
