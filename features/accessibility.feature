Feature: Accessibility
  As Pension Wise
  We want the service to be accessible to as many people as possible
  So that no one is excluded

  Scenario Outline: Document formats
    Given the customer prefers to receive their summary document in <format> format
    When we preview their summary document
    Then it should be in <format> format

    Examples:
      | format     |
      | standard   |
      | large text |
