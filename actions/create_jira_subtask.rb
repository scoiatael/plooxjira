# frozen_string_literal: true
class CreateJiraSubtask
  def initialize(title:, url: nil, parent:)
    @title = title
    @url = url
    @parent = parent
  end

  def call(_)
    Actions::Jira::CreateIssue
      .new(type: Jira.subtask_id)
      .call(title: @title, url: @url) do |issue|
      issue.fields.set_id('parent', @parent)
    end
  end
end
