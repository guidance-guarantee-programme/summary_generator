When(/^we send (?:them their|a) record of guidance$/) do
  page = AppointmentSummaryPage.new
  page.load
  page.fill_in(@appointment_summary)
  page.submit.click
end

Then(/^the sections it includes should be \(in order\):$/) do |table|
  sections = table.raw.flatten

  expect(page).to include_output_document_sections(sections)
end

Given(/^we have captured the customer's details in an appointment summary$/) do
  @appointment_summary = fixture(:populated_appointment_summary)
end

Then(/^the record of guidance should include their details$/) do
  output_document = OutputDocument.new(@appointment_summary)

  expect(page).to have_content(output_document.attendee_name)
end

Given(/^we have captured appointment details in an appointment summary$/) do
  @appointment_summary = fixture(:populated_appointment_summary)
end

Then(/^the record of guidance should include the details of the appointment$/) do
  output_document = OutputDocument.new(@appointment_summary)

  expect(page).to have_content(output_document.appointment_date)
  expect(page).to have_content(output_document.guider_first_name)
  expect(page).to have_content(output_document.guider_organisation)
end
