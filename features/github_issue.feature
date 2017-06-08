Feature: Close github issue
  Scenario: User closes github issue
    When I close Github issue named "[SDB-111] Foo bar"
    Then I want Jira issue with id "SBD-111" to be marked as "Done"
