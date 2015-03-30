Feature: Create record of guidance
  As a Pension Wise customer
  I want a record of my guidance appointment
  So that I can review my appointment in my own time without relying on memory or my own notes

Scenario: Capture and email a record of guidance
  When appointment details are captured
  And I preview the record of guidance document
  Then a record of guidance document is created
