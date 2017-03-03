# Finds issue by key
# e.g. FindJiraIssue.new.('SBD-51')
class FindJiraIssue
  def call(key)
    Jiralicious::Issue.find(key)
  end
end
