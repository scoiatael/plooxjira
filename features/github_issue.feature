Feature: React to transitions of github issues
  Scenario: User closes github issue
    Given issue named "SBD-111" can be marked as "Done"

    When I close Github issue named "[SBD-111] Foo bar"
    Then I want Jira issue with id "SBD-111" to be marked as "Done"
