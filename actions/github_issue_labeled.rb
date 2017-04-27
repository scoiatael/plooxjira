# frozen_string_literal: true
class GithubIssueLabeled
  def initialize(key: nil, issue:)
    @key = key
    @issue = issue
  end

  def call(params)
    label = params['label']

    SetJiraIssueEstimate.new(key: @key).call(params)
    CreateJiraIssue.new(issue: @issue, label: label).call(params) unless @key
  end
end
