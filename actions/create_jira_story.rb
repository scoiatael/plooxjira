# frozen_string_literal: true
class CreateJiraStory
  def initialize(title:, url: nil)
    @title = title
    @url = url
  end

  def call(_)
    Actions::Jira::CreateIssue
      .new(type: Jira.story_id)
      .call(title: @title, url: @url) do |issue|
      issue.fields.set_name('assignee', Jira.assignee)
    end
  end
end
