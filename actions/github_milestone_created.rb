# Handler for creation of Github milestone
class GithubMilestoneCreated
  def initialize(milestone)
    @title = milestone['title']
    @url = milestone['url']
    @number = milestone['number']
  end

  def call(params)
    issue_key = CreateJiraStory.new(title: @title, url: @url).call(params)
    puts "Created Jira issue with key #{issue_key}"
    SetMilestoneTitle.new(repository: params['repository']['full_name'],
                          number: @number,
                          title: "[#{issue_key}] #{@title}").call(params)
  end
end