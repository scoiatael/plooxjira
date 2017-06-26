Feature: React to transitions of github milestones
  Scenario: User creates github milestone
    Given next Jira issue created will have key "SBD-11"

    When I create Github milestone number "33" named "Foo bar"
    Then I want Jira user story named "Foo bar" created
    And I want Github milestone number "33" title changed to "[SBD-11] Foo bar"
