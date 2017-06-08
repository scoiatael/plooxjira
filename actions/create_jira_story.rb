# frozen_string_literal: true
class CreateJiraStory
  def initialize(title:, url: nil, description: '')
    @title = title
    @url = url
    @description = description
  end

  def call(_)
    Actions::Jira::CreateIssue
      .new(type: Jira.story_id)
      .call(title: @title, url: @url, description: @description) do |issue|
      issue.fields.set_name('assignee', Jira.assignee)
    end
  end
end
