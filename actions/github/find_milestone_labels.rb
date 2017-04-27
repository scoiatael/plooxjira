# frozen_string_literal: true
module Actions
  module Github
    # Lists all labels for milestone:
    # e.g.
    # ListMilestoneLabels.new("nowthisnews/insights-platform", 8)
    class ListMilestoneLabels
      def initialize(repository, milestone)
        @repository = repository
        @milestone = milestone
      end

      def call(state: :all)
        ::Github
          .client
          .list_issues(@repository, milestone: @milestone, state: state)
          .flat_map { |issue| issue[:labels] }
          .group_by { |label| label[:name] }
      end
    end
  end
end
