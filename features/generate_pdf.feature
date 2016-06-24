Feature: Generate PDF
  As a Pension Wise face-to-face guider
  I want PDFs of customers' output documents
  So that I have flexibility in how I distribute and process them

Scenario: Capture and email a summary document
  Given a customer has had a Pension Wise appointment
  When we generate their summary document
  Then a PDF output document is created
