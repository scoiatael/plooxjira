class CommentJiraIssue
  def initialize(key:, body:)
    @key = key
    @body = body
  end

  def call
    Jiralicious::Issue::Comment.add({ body: @body }, @key)
  end
end
