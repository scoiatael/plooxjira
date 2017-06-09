# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
ENV['JIRA_USER'] = 'test-user'
ENV['JIRA_PASS'] = 'extra-secret-pass'
ENV['JIRA_URL'] = 'http://localhost'
ENV['GH_ACCESS_TOKEN'] = 'some-long-token'

require 'fakeweb'
require 'rspec'
require 'pry'
require_relative '../../config'
require_relative '../../app'

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
  body: JSON.dump(fixture('jira_login'))
)

require 'rack/test'

module TestApp
  def app
    App
  end
end

World(Rack::Test::Methods)
World(TestApp)
