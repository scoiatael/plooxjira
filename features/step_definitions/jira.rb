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
    body: JSON.dump(fixture('jira_issue_transitions'))
      .gsub('$TRANSITION_NAME$', final_state).gsub('$TRANSITION_ID$', id)
  )
  FakeWeb.register_uri(
    :post,
    url,
    body: ''
  )
end

Given(/^next Jira issue created will have key "([^"]*)"$/) do |jira_key|
  url = Jiralicious.uri + '/rest/api/latest/issue/'
  FakeWeb.register_uri(
    :post,
    url,
    body: <<~EOF
      {
        "id":"39000",
        "key":"#{jira_key}",
        "self":"http://localhost/rest/api/latest/issue/39000"
      }
    EOF
  )
end

Then(/^I want Jira user story named "([^"]*)" created$/) do |arg1|
  # TODO: Write this test.
  # NOTE: Unfortunately FakeWeb only gives last request, and by time test gets here there were already multiple HTTP requests made.
end
