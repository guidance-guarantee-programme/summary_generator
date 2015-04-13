Feature: Generate PDF
  As a Pension Wise face-to-face guider
  I want PDFs of customers' output documents
  So that I have flexibility in how I distribute and process them

Scenario: Capture and email a record of guidance
  Given I have captured some appointment details
  And I have previewed the output document
  When I confirm the preview
  Then a PDF output document is created
