class NilAction
  def initialize(title)
    @title = title
  end

  def call(_params)
    puts "#{@tile} called"
  end
end
