# frozen_string_literal: true
# Sets title for issue:
# e.g.
# SetIssueTitle.new(repository: 'nowthisnews/insights-platform',
#                       number: 2,
#                       title: 'Provide scalable platform')
class SetIssueTitle
  def initialize(repository:, number:, title:)
    @repository = repository
    @number = number
    @title = title
  end

  def call(_)
    Github.client.update_issue @repository, @number, title: @title
  end
end
