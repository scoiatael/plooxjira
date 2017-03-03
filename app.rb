# Api entrypoint
class App < Sinatra::Base
  before do
    request.body.rewind
    @body = request.body.read
  end

  post '/payload' do
    signature = env['X-Hub-Signature'] || env['HTTP_X_HUB_SIGNATURE']
    _, signature = signature.split('=')
    body_hmac = CalculateHubSignature.new.call(@body)
    puts "Body: #{params}"
    puts "Sig: #{signature} Hmac: #{body_hmac}"
    ok = body_hmac == signature
    return [400, JSON.dump(error: 'Bad signature')] unless ok

    action = FindGithubAction.new.call(params)
    puts "Action: #{action}"

    action.call(params)

    'OK'
  end
end
