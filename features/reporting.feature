Feature: Covering letter
  As Pension Wise
  We want to store customer details for reporting
  So we can use the result to provide a better service

  Scenario: Details of the appointment are stored for reporting
    Given a customer has had a Pension Wise appointment
    When we send them their summary document
    And I confirm the preview
    Then details of the document should be persisted for reporting
