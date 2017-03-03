# Api entrypoint
class App < Sinatra::Base
  before do
    request.body.rewind
    @body = request.body.read
  end

  post '/payload' do
    signature = env['X-Hub-Signature'] || env['HTTP_X_HUB_SIGNATURE']
    ok = CalculateHubSignature.new.call(@body) == signature
    return [400, JSON.dump(error: 'Bad signature')] unless ok

    'OK'
  end
end
