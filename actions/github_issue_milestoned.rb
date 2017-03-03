class GithubIssueMilestoned
  def initialize(issue:, key:)
    @title = issue.fetch('title')
    @url = issue['html_url']
    @key = key
  end

  def call(params)
    id = FindJiraIssue.new.call(@key).id
    CreateJiraSubtask.new(parent: id, title: @title, url: @url).call(params)
  end
end
