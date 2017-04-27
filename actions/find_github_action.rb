# Builds action for Github webhook
# issue closed -> close Jira issue
# issue reponed -> move Jira issue to in progress
# comment created -> add Jira comment
# milestone created -> create Jira story and update milestone
# issue milestoned -> create Jira subtask and update issue
# issue labeled -> update Jira storypoints / and/or create jira issue
class FindGithubAction
  TITLE_REGEX = /\[(?<jira_key>.*)\].*/

  def self.extract_jira_key(issue)
    TITLE_REGEX.match(issue.fetch('title'))&.[](:jira_key)
  end

  def call(params)
    @params = params
    action = params['action']
    issue = params['issue']

    return dispatch_issue(action, issue) if issue

    milestone = params['milestone']
    dispatch_milestone(action, milestone) if milestone
  end

  private

  def dispatch_issue(action, issue)
    default = NilAction.new("Issue: #{issue}, Action: #{action}")

    issue_action(issue, action, default: default)
  end

  def issue_action(issue, action, default:)
    jira_key = self.class.extract_jira_key(issue)

    case action
    when 'milestoned'
      GithubIssueMilestoned.new(issue: issue, key: self.class.extract_jira_key(issue['milestone']))
    when 'closed'
      FixJiraIssue.new(key: jira_key, status: 'Done')
    when 'reopened'
      FixJiraIssue.new(key: jira_key, status: 'In Progress')
    when 'created'
      CommentJiraIssue.new(key: jira_key, body: extract_comment_body(@params))
    when 'assigned'
      FixJiraIssue.new(key: jira_key, status: 'In Progress')
    when 'labeled'
      GithubIssueLabeled.new(issue: issue, key: jira_key)
    else
      default
    end
  end

  def extract_comment_body(params)
    username = params['comment']['user']['login']
    comment_url = params['comment']['html_url']
    body = params['comment']['body']
    <<~EOF
      #{username} via GitHub: #{comment_url}
      #{body}
    EOF
  end

  def dispatch_milestone(action, milestone)
    title = milestone['title']
    default = NilAction.new("Milestone: #{title}, Action: #{action}")
    case action
    when 'created'
      GithubMilestoneCreated.new(milestone)
    else
      default
    end
  end
end
