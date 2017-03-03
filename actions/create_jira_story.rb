class CreateJiraStory
  def initialize(title:, url: nil)
    @title = title
    @url = url
  end

  def call(_)
    issue = Jiralicious::Issue.new
    issue.fields.set_id('project', Jira.project)
    issue.fields.set('summary', @title)
    issue.fields.set_id('issuetype', Jira.story_id)
    issue.fields.set_name('assignee', Jira.assignee)
    issue.fields.set('description', @url) if @url
    issue.save!

    issue.jira_key
  end
end
