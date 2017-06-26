Feature: React to transitions of github issues
  Scenario: User closes github issue
    Given issue named "SBD-111" can be marked as "Done" ["51"]

    When I close Github issue named "[SBD-111] Foo bar"
    Then I want Jira issue with id "SBD-111" to be marked as "Done" ["51"]

  Scenario: User labels github issue
    Given next Jira issue created will have key "SBD-11"
    And Github issue number "33" named "Foo bar"

    When I label Github issue named "Foo bar" number "33" with "user-story"
    Then I want Jira user story named "Foo bar" created
    And I want Github issue number "33" title changed to "[SBD-11] Foo bar"
