# Builds action for Github webhook
# issue closed -> close Jira issue
# issue reponed -> move Jira issue to in progress
# comment created -> add Jira comment
class FindGithubAction
  TITLE_REGEX = /\[(?<jira_key>.*)\].*/

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
    jira_key = extract_jira_key(issue)
    default = NilAction.new("Issue: #{jira_key}, Action: #{action}")

    return default unless issue && jira_key

    issue_action(jira_key, action, default: default)
  end

  def issue_action(jira_key, action, default:)
    case action
    when 'closed'
      FixJiraIssue.new(key: jira_key, status: 'Done')
    when 'reopened'
      FixJiraIssue.new(key: jira_key, status: 'In Progress')
    when 'created'
      CommentJiraIssue.new(key: jira_key, body: extract_comment_body(@params))
    when 'assigned'
      FixJiraIssue.new(key: jira_key, status: 'In Progress')
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

  def extract_jira_key(issue)
    TITLE_REGEX.match(issue.fetch('title'))&.[](:jira_key)
  end

  def dispatch_milestone(action, milestone)
    title = milestone['title']
    default = NilAction.new("Issue: #{title}, Action: #{action}")
    case action
    when 'created'
      CreateJiraStory.new(title: title, url: milestone['html_url'])
    else
      default
    end
  end
end
