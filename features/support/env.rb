# frozen_string_literal: true

require_relative '../../config'
require 'fakeweb'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

FakeWeb.allow_net_connect = false

Jiralicious.configure do |config|
  config.username = 'jstewart'
  config.password = 'topsecret'
  config.uri = 'http://localhost'
  config.api_version = 'latest'
  config.auth_type = :cookie
end

def fixture(name)
  path = "#{File.dirname(__FILE__)}/fixtures/#{name}.json"
  JSON.parse(File.read(path))
end

FakeWeb.register_uri(
  :post,
  Jiralicious.uri + '/rest/auth/latest/session',
  body: fixture('jira_login')
)
