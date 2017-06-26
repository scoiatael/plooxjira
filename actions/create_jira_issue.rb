# frozen_string_literal: true
class CreateJiraIssue
  def initialize(issue:, label:)
    @title = issue.fetch('title')
    @url = issue['html_url']
    @number = issue['number']

    @type = type_of(label.fetch('name'))
  end

  def call(params)
    return unless @type
    issue_key = Actions::Jira::CreateIssue
                .new(type: @type)
                .call(title: @title, url: @url)

    SetIssueTitle.new(repository: params['repository']['full_name'],
                      number: @number,
                      title: "[#{issue_key}] #{@title}").call(params)
    issue_key
  end

  private

  def type_of(name)
    case name
    when 'bug'
      Jira.bug_id
    when 'task'
      Jira.task_id
    when 'user-story'
      Jira.story_id
    end
  end
end
