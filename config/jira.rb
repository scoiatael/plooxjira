# frozen_string_literal: true

Jiralicious.configure do |config|
  # Leave out username and password
  config.username = ENV['JIRA_USER']
  config.password = ENV['JIRA_PASS']
  config.uri = ENV['JIRA_URL']
  config.api_version = 'latest'
  config.auth_type = :basic
end

# Global configuration values
module Jira
  module_function def project
    ENV.fetch('JIRA_PROJECT')
  end

  module_function def assignee
    ENV.fetch('JIRA_ASSIGNEE')
  end

  module_function def story_id
    ENV.fetch('JIRA_STORY_ID')
  end

  module_function def subtask_id
    ENV.fetch('JIRA_SUBTASK_ID')
  end

  module_function def component
    ENV.fetch('JIRA_COMPONENT')
  end

  module_function def storypoints_field_id
    ENV.fetch('JIRA_STORYPOINTS_FIELD_ID')
  end

  module_function def bug_id
    ENV.fetch('JIRA_BUG_ID')
  end

  module_function def task_id
    ENV.fetch('JIRA_TASK_ID')
  end
end
