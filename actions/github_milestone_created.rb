# frozen_string_literal: true
# Handler for creation of Github milestone
class GithubMilestoneCreated
  def initialize(milestone)
    @title = milestone['title']
    @url = milestone['url']
    @number = milestone['number']
    @description = milestone['description']
  end

  def call(params)
    existing_issue = FindGithubAction.extract_jira_key('title' => @title)
    return if existing_issue

    issue_key = CreateJiraStory.new(title: @title,
                                    url: @url,
                                    description: @description).call(params)
    puts "Created Jira issue with key #{issue_key}"
    SetMilestoneTitle.new(repository: params['repository']['full_name'],
                          number: @number,
                          title: "[#{issue_key}] #{@title}").call(params)
  end
end
