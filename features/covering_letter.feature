@wip
Feature: Covering letter
  As Pension Wise
  We want to set customer's expectations about their record of guidance
  So they understand what they’ve been sent and what it’s for

Scenario: Records of guidance are sent with a covering letter
  When we send a customer a record of guidance
  Then it should include a covering letter
