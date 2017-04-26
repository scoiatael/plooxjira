# frozen_string_literal: true
module Actions
  module Jira
    # Change story_points of Jira issue
    # e.g. SetIssueStoryPoints.new(key: 'SBD-240').call(5)
    class SetIssueStoryPoints
      def initialize(key:)
        @key = key
      end

      def call(story_points)
        issue = FindJiraIssue.new.call(@key)
        issue.fields.set(::Jira.storypoints_field__id, story_points)
        issue.save!
      end
    end
  end
end
