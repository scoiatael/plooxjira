# frozen_string_literal: true
module Actions
  module Jira
    # Creates Jira issue
    # e.g. CreateIssue.new(type: Jira.subtask_id).call(title: "My hair is on fire") { |issue| isue.set_id(parent, @parent) }
    class CreateIssue
      def initialize(type:)
        @type = type
      end

      def call(title:, url: nil, description: '')
        issue = Jiralicious::Issue.new
        issue.fields.set_id('project', ::Jira.project)
        issue.fields.set('customfield_' + ::Jira.team_customfield_id, ::Jira.team_id)
        issue.fields.set('components', [{ id: ::Jira.component }])
        issue.fields.set('summary', title)
        issue.fields.set_id('issuetype', @type)
        description += "\n#{url}"
        issue.fields.set('description', description)
        yield(issue) if block_given?
        issue.save!

        issue.jira_key
      end
    end
  end
end
