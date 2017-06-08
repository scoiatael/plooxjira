When(/^I close Github issue named "([^"]*)"$/) do |issue_name|
  body = JSON.dump(foo: :Bar)
  post '/payload', body, { 'HTTP_X_Hub_SIGNATURE' => CalculateHubSignature.new.call(body) }
end
