# Change story_points of Jira issue based on Github tag assigned to it
# e.g. SetJiraIssueEstimate.new(key: 'SBD-240').call({ 'label': { 'name': 'L'}})
class SetJiraIssueEstimate
  def initialize(key:)
    @key = key
  end

  def call(params)
    label = params.dig('label', 'name')
    return unless label
    story_points = find_estimate(label)
    return unless story_points
    update_story_points(story_points)
  end

  private

  def update_story_points(story_points)
    issue = FindJiraIssue.new.call(@key)
    issue.fields.set(Jira.storypoints_field__id, story_points)
    issue.save!
  end

  def find_estimate(name)
    case name
    when 'S'
      2
    when 'M'
      3
    when 'L'
      5
    when 'XL'
      8
    end
  end
end
