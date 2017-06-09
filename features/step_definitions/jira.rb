# frozen_string_literal: true

# TODO: Connect status with id
Then(/^I want Jira issue with id "([^"]*)" to be marked as "([^"]*)" \["([^"]*)"\]$/) do |issue, _status, id|
  req = FakeWeb.last_request
  expect(req.path).to eq "/rest/api/latest/issue/#{issue}/transitions/"
  expect(req.body).to eq "{\"transition\":{\"id\":\"#{id}\"}}"
end

Given(/^issue named "([^"]*)" can be marked as "([^"]*)" \["([^"]*)"\]$/) do |issue, final_state, id|
  url = Jiralicious.uri + "/rest/api/latest/issue/#{issue}/transitions/"
  FakeWeb.register_uri(
    :get,
    url,
    body: JSON.dump(fixture('jira_issue_transitions')).gsub('$TRANSITION_NAME$', final_state).gsub('$TRANSITION_ID$', id)
  )
  FakeWeb.register_uri(
    :post,
    url,
    body: ''
  )
end
