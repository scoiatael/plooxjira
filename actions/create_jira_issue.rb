# frozen_string_literal: true
class CreateJiraIssue
  def initialize(issue:, label:)
    @title = issue.fetch('title')
    @url = issue['html_url']
    @number = issue['number']

    @type = label.fetch('name')
  end

  def call(params)
    return unless @type == 'bug'
    issue_key = Actions::Jira::CreateIssue
                .new(type: Jira.bug_id)
                .call(title: @title, url: @url)

    SetIssueTitle.new(repository: params['repository']['full_name'],
                      number: @number,
                      title: "[#{issue_key}] #{@title}").call(params)
  end
end
