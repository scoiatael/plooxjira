# frozen_string_literal: true
class GithubIssueLabeled
  def initialize(key: nil, issue:, label:)
    @key = key
    @issue = issue
    @label = label
  end

  def call(params)
    SetJiraIssueEstimate.new(key: @key).call(params)
    CreateJiraIssue.new(issue: @issue, label: @label).call(params) unless @key
  end
end
