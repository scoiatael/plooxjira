class CreateJiraStory
  def initialize(title:, url: nil)
    @title = title
    @url = url
  end

  def call(_)
    issue = Jiralicious::Issue.new
    issue.fields.set_id('project', '12400')
    issue.fields.set('summary', @title)
    issue.fields.set_id('issuetype', '10001')
    issue.fields.set_name('assignee', 'lukasz.czaplinski')
    issue.fields.set('description', @url) if @url
    issue.save!

    issue.jira_key
  end
end
