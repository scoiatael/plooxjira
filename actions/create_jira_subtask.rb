class CreateJiraSubtask
  def initialize(title:, url: nil, parent:)
    @title = title
    @url = url
    @parent = parent
  end

  def call(_)
    issue = Jiralicious::Issue.new
    issue.fields.set_id('parent', @parent)
    issue.fields.set_id('project', '12400')
    issue.fields.set('summary', @title)
    issue.fields.set_id('issuetype', '10003')
    issue.fields.set('description', @url) if @url
    issue.save!

    issue.jira_key
  end
end
