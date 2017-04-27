# frozen_string_literal: true
module Actions
  module Jira
    # Creates Jira issue
    # e.g. CreateIssue.new(type: Jira.subtask_id).call(title: "My hair is on fire") { |issue| isue.set_id(parent, @parent) }
    class CreateIssue
      def initialize(type:)
        @type = type
      end

      def call(title:, url: nil)
        issue = Jiralicious::Issue.new
        issue.fields.set_id('project', @type)
        issue.fields.set('summary', title)
        issue.fields.set_id('issuetype', Jira.story_id)
        issue.fields.set('description', url) if url
        yield(issue) if block_given?
        issue.save!

        issue.jira_key
      end
    end
  end
end
