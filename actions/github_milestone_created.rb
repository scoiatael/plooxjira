# Handler for creation of Github milestone
class GithubMilestoneCreated
  def initialize(milestone)
    @title = milestone['title']
    @url = milestone['url']
    @number = milestone['number']
  end

  def call(params)
    issue_key = CreateJiraStory.new(title: @title, url: @url)
    SetMilestoneTitle.new(repository: params['repository']['full_name'],
                          number: @number,
                          title: "[#{issue_key}] #{@title}")
  end
end
