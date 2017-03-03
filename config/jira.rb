Jiralicious.configure do |config|
  # Leave out username and password
  config.username = ENV['JIRA_USER']
  config.password = ENV['JIRA_PASS']
  config.uri = 'https://nowthis.atlassian.net'
  config.api_version = 'latest'
  config.auth_type = :basic
end
