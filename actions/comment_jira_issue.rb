class CommentJiraIssue
  def initialize(key:, body:)
    @key = key
    @body = body
  end

  def call(_params)
    Jiralicious::Issue::Comment.add({ body: @body }, @key)
  end
end
