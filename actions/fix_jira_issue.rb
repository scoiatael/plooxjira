# Change status of Jira issue.
# By default changes to 'Done'
# e.g. FixJiraIssue.new(status: 'In Progress', key: 'SBD-240').call
class FixJiraIssue
  def initialize(status: 'Done', key:)
    @status = status
    @key = key
  end

  def call(_)
    transitions = Jiralicious::Issue::Transitions.find(@key)
    transition_key = find_transition_key(transitions)
    transitions[transition_key].go
  end

  private

  def find_transition_key(transitions)
    transitions.find(&method(:with_proper_status)).first
  end

  def with_proper_status((_, h))
    h.is_a?(Hash) && h['name'] == @status
  end
end
