class App < Sinatra::Base
  post '/payload' do
    puts '--- Received'
    p params
    puts '---'
    'OK'
  end
end
