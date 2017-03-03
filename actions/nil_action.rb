class NilAction
  def initialize(title)
    @title = title
  end

  def call(_params)
  end

  def to_s
    "NilAction: #{@title}"
  end
end
