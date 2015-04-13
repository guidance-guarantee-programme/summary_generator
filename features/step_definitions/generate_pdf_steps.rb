Given(/^I have captured some appointment details$/) do
  @appointment_summary = fixture(:populated_appointment_summary)
end

Given(/^I have previewed the output document$/) do
  page = AppointmentSummaryPage.new
  page.load
  page.fill_in(@appointment_summary)
  page.submit.click
end

When(/^I confirm the preview$/) do
  page = RecordOfGuidancePreviewPage.new
  page.confirm.click
end

Then(/^a PDF output document is created$/) do
  expect(page.response_headers['Content-Type']).to eql('application/pdf')
  expect { PDF::Inspector::Text.analyze(page.source) }.not_to raise_error
end
