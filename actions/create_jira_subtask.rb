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
      .call(title: @title, url: @url).call do |issue|
      issue.fields.set_id('parent', @parent)
      issue.fields.set('components', [{ id: Jira.component }])
    end
  end
end
