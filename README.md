# Plooxjira - JiraBot

- [x] When I close GitHub issue, I want respective Jira issue to be marked as Done.
- [x] When I reopen GitHub issue, I want respective Jira issue to be marked as In Progress.

- [x] When I assign a person to GitHub issue, I want respective Jira issue to be marked as In Progress.

- [x] When I add comment on GitHub issue, I want respective Jira issue to have comment added.

- [x] When I create a milestone on Github, I want respective Jira story to be created.
- [x] When I create a milestone on Github, I want respective Jira story key to be added to it.

- [x] When I add a milestone to issue on Github, I want respective Jira story have sub-task created.

## Setup

### Environment variables
* `JIRA_USER` - your Jira username. The one you use to log in on https://id.atlassian.com
* `JIRA_PASS` - password, similar to above.
* `GH_ACCESS_TOKEN` - your Github access token. Generate new on https://github.com/settings/tokens with `repo` (Full control of private repositories) permissions
* `GH_SECRET` - random value, generate new on each deployment.

### Webhooks
Set up webhooks for repository which issues should sync to Jira:
* send all events ('send everything' options when adding new webhook)
* `application/json` content type
* secret value equal to `GH_SECRET` you generated during deployment
