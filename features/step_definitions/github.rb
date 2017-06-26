# frozen_string_literal: true

def webhook(fixture_name, context = {})
  body = JSON.dump(fixture(fixture_name))
  context.each do |k, v|
    body.gsub!(k, v)
  end
  sig = CalculateHubSignature.new.call(body)
  post '/payload', body,
       'HTTP_X_HUB_SIGNATURE' => "sha256=#{sig}",
       'CONTENT_TYPE' => 'application/json'
end

When(/^I close Github issue named "([^"]*)"$/) do |issue_name|
  webhook('issue_closed', '$ISSUE_NAME$' => issue_name)
  expect(last_response).to be_ok
end

When(/^I create Github milestone number "([^"]*)" named "([^"]*)"$/) do |milestone_number, milestone_name|
  url = "https://api.github.com/repos/nowthisnews/insights-platform/milestones/#{milestone_number}"
  FakeWeb.register_uri(
    :patch,
    url,
    body: <<~EOF
    EOF
  )

  webhook('github_milestone_created',
          '$MILESTONE_NAME$' => milestone_name,
          '"$MILESTONE_NUMBER$"' => milestone_number)
  expect(last_response).to be_ok
end

Then(/^I want Github milestone number "([^"]*)" title changed to "([^"]*)"$/) do |number, title|
  req = FakeWeb.last_request
  expect(req.path).to eq "/repos/nowthisnews/insights-platform/milestones/#{number}"
  expect(req.body).to eq "{\"title\":\"#{title}\"}"
end

Given(/^Github issue number "([^"]*)" named "([^"]*)"$/) do |number, _name|
  url = "https://api.github.com/repos/nowthisnews/insights-platform/issues/#{number}"
  FakeWeb.register_uri(
    :patch,
    url,
    body: <<~EOF
    EOF
  )
end

When(/^I label Github issue named "([^"]*)" number "([^"]*)" with "([^"]*)"$/) do |name, number, label|
  webhook('github_issue_labeled',
          '$ISSUE_NAME$' => name,
          '$LABEL$' => label,
          '"$ISSUE_NUMBER$"' => number)
  expect(last_response).to be_ok
end

Then(/^I want Github issue number "([^"]*)" title changed to "([^"]*)"$/) do |number, title|
  req = FakeWeb.last_request
  expect(req.path).to eq "/repos/nowthisnews/insights-platform/issues/#{number}"
  expect(req.body).to eq "{\"title\":\"#{title}\"}"
end
