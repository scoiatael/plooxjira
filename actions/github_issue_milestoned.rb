# frozen_string_literal: true
class GithubIssueMilestoned
  def initialize(issue:, key:)
    @title = issue.fetch('title')
    @url = issue['html_url']
    @key = key
    @number = issue['number']
  end

  def call(params)
    return if FindGithubAction.extract_jira_key('title' => @title)
    issue_key = CreateJiraSubtask.new(parent: @key, title: @title, url: @url).call(params)

    SetIssueTitle.new(repository: params['repository']['full_name'],
                      number: @number,
                      title: "[#{issue_key}] #{@title}").call(params)
  end
end
