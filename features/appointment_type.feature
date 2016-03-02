Feature: Appointment type
  As Pension Wise
  We want to offer tailored appointments to customers
  So we can provide relevant information where possible

  Scenario Outline: Appointment types
    Given the customer is given the <type> appointment
    When we generate a summary document
    Then it should be the <type> type of summary document

    Examples:
      | type     |
      | standard |
      | 50-54    |
