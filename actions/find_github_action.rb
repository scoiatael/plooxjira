class FindGithubAction
  def call(params)
    type = params['action']
    has_issue = params.key?('issue')

    NilAction.new("Type: #{type}, HasIssue: #{has_issue}")
  end
end
