# frozen_string_literal: true
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
    Actions::Jira::SetIssueStoryPoints.new(key: @key).call(story_points)
    milestone = params.dig('issue', 'milestone')
    return unless milestone
    milestone_number = milestone.fetch('number')
    milestone_key = FindGithubAction.extract_jira_key(milestone)
    return unless milestone_key

    update_milestone_story_points(
      milestone_key,
      Actions::Github::ListMilestoneLabels
        .new(params.dig('repository', 'full_name'), milestone_number)
        .call)
  end

  private

  def update_milestone_story_points(milestone_key, labels)
    milestone_estimate = labels
                         .map { |k, v| [find_estimate(k), v.size] }
                         .reject { |k, _| k.nil? }
                         .map { |k, v| k * v }
                         .reduce(:+)

    Actions::Jira::SetIssueStoryPoints
      .new(key: milestone_key)
      .call(milestone_estimate)
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
