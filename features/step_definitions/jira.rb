Then(/^I want Jira issue with id "([^"]*)" to be marked as "([^"]*)"$/) do |issue_id, issue_status|
end

Given(/^issue named "([^"]*)" can be marked as "([^"]*)"$/) do |issue, final_state|
  url = Jiralicious.uri + "/rest/api/latest/issue/#{issue}/transitions/"
  FakeWeb.register_uri(
    :get,
    url,
    body: JSON.dump(fixture('jira_issue_transitions')).gsub('$TRANSITION_NAME$', final_state)
  )
  FakeWeb.register_uri(
    :post,
    url,
    body: ''
  )
end
