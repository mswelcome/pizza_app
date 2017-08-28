#Pizza App

require "sinatra"
enable :sessions



get '/' do

  erb :select

end
  $cost = 0

post '/select' do
  p "#{$cost}"
  session[:meats] = params[:meats]
  session[:veggies] = params[:veggies]
  session[:cheese] = params[:cheese]
  session[:size] = params[:size]

  if session[:size] == 'extralarge'
    $cost = $cost + 15
  elsif session[:size] == 'large'
    $cost = $cost + 12
  elsif session[:size] == 'medium'
    $cost = $cost + 9
  else session[:size] == 'small'
    $cost = $cost + 7
  end

  session[:total] = $cost
  session[:delivery] = params[:delivery]

  redirect '/confirm?'

end

get '/confirm' do

  erb :confirm, locals: {total: session[:total], meats: session[:meats], veggies: session[:veggies], cheese: session[:cheese], size: session[:size], delivery: session[:delivery]}

end

post '/res' do
  session[:address] = params[:address]
  session[:conf] = params[:conf].values

  redirect '/more?'

end

get '/more' do


    erb :more, locals: {conf: session[:conf], address: session[:address], size: session[:size]}

end

post '/final' do
  session[:pies] = session[:pies] || []
  session[:pies] << session[:conf]
  p "#{session[:conf]} Confirm"
  p "#{session[:pies]} Pies"
  bzzz = params[:bzzz]
  @params = params
  print @params
  if bzzz == "yes"
    redirect '/?'
  else bzzz == "no"
    redirect  '/results?'
  end
end



get '/results' do

    erb :results, locals: {pies: session[:pies], size: session[:size], address: session[:address]}

end
