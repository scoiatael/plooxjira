class App < Sinatra::Base
  before do
    request.body.rewind
    @body = request.body.read
  end

  post '/payload' do
    signature = env['X-Hub-Signature'] || env['HTTP_X_HUB_SIGNATURE']
    puts "Signature: #{signature}"
    body_hmac = CalculateHubSignature.new.call(params)
    body_hmac2 = CalculateHubSignature.new.call(@body)
    puts "Calculated: #{body_hmac}, #{body_hmac2}"
    'OK'
  end
end
