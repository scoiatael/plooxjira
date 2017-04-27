# Plooxjira - JiraBot

- [x] When I close GitHub issue, I want respective Jira issue to be marked as Done.
- [x] When I reopen GitHub issue, I want respective Jira issue to be marked as In Progress.

- [x] When I assign a person to GitHub issue, I want respective Jira issue to be marked as In Progress.

- [x] When I add comment on GitHub issue, I want respective Jira issue to have comment added.

- [x] When I create a milestone on Github, I want respective Jira story to be created.
- [x] When I create a milestone on Github, I want respective Jira story key to be added to it.

- [x] When I add a milestone to issue on Github, I want respective Jira story have sub-task created.

- [x] When I add an estimate to GitHub issue, I want respective Jira story to have story points field updated.
- [x] When I add an estimate to GitHub issue, and issue is part of milestone, I want respective Jira user story to have story points field updated.

## Setup

### Environment variables
* `JIRA_USER` - your Jira username. The one you use to log in on https://id.atlassian.com
* `JIRA_PASS` - password, similar to above.
* `JIRA_URL` - url of your Jira instance
* `JIRA_PROJECT` - project where new stories should be created
* `JIRA_ASSIGNEE` - default assignee for Jira stories
* `JIRA_STORY_ID` - id for Jira story - get that from your Jira instance
* `JIRA_SUBTASK_ID` - id for Jira subtask
* `JIRA_BUG_ID` - id for Jira bug
* `JIRA_TASK_ID` - id for Jira task
* `JIRA_STORYPOINTS_FIELD_ID` - id for Jira story points field
* `GH_ACCESS_TOKEN` - your Github access token. Generate new on https://github.com/settings/tokens with `repo` (Full control of private repositories) permissions
* `GH_SECRET` - random value, generate new on each deployment.

### Webhooks
Set up webhooks for repository which issues should sync to Jira:
* send all events ('send everything' options when adding new webhook)
* `application/json` content type
* secret value equal to `GH_SECRET` you generated during deployment

## Know-how and rough edges

### Jira integration
https://github.com/dorack/jiralicious
Uses HTTP Basic authentication - should probably use OAuth for multiple users. But one can get cancer from trying to implement Jira OAuth in Ruby.
Reading jiralicious is probably the fastest way to finding how to do various things.
Also, most of calls take magical 'ids' which are quite hard to obtain if you want to hardcode something (https://answers.atlassian.com/questions/274265/jira-project-id).

Problems:
* project is hard-coded
* assignee for stories is hardcoded (me)
* ids for stories / subtasks are hardcoded (they are Jira-instance-dependent?)

### Github integration
#### API
https://github.com/octokit/octokit.rb
Uses Personal Access Token - downside of granting access to all repositories. But AFAIR Github API does not have better approach. Of course, it'd be much nicer to implement GitHub OAuth to get access token from that, instead of manually generating.
Nice and easy. Awesome API documentation (https://octokit.github.io/octokit.rb/method_list.html).

#### Webhooks
Different beast. It's easiest to simply trigger a webhook, observe payload sent in webhook settings and then write code accordingly.
