module Github
  module_function def client
    @client ||= Octokit::Client.new(access_token: ENV['GH_ACCESS_TOKEN'])
  end
end
