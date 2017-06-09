# frozen_string_literal: true

When(/^I close Github issue named "([^"]*)"$/) do |issue_name|
  body = JSON.dump(fixture('issue_closed')).gsub('$ISSUE_NAME$', issue_name)
  sig = CalculateHubSignature.new.call(body)
  post '/payload', body, 'HTTP_X_HUB_SIGNATURE' => "sha256=#{sig}", 'CONTENT_TYPE' => 'application/json'
  expect(last_response).to be_ok
end
