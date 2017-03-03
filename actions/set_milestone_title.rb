# Sets title for milestone:
# e.g.
# SetMilestoneTitle.new(repository: 'nowthisnews/insights-platform',
#                       number: 2,
#                       title: 'Provide scalable platform')
class SetMilestoneTitle
  def initialize(repository:, number:, title:)
    @repository = repository
    @number = number
    @title = title
  end

  def call(_)
    Github.client.update_milestone @repository, @number, title: @title
  end
end
