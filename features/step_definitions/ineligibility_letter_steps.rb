Given(/^the customer doesn't have a defined contribution pension pot$/) do
  @appointment_summary = fixture(:populated_appointment_summary).tap do |as|
    as.has_defined_contribution_pension = 'no'
  end
end

Then(/^an ineligibility letter will be generated$/) do
  expect(page).to include_output_document_section('ineligible')

  output_document = OutputDocument.new(@appointment_summary)
  expect(page).to have_content(output_document.attendee_address)
  expect(page).to have_content(output_document.attendee_name)
  expect(page).to have_content(output_document.lead)
end
