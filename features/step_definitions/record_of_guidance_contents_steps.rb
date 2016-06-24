Given(/^the customer doesn’t require any supplementary information$/) do
  @appointment_summary = fixture(:populated_appointment_summary).tap do |as|
    as.supplementary_benefits = false
    as.supplementary_debt = false
    as.supplementary_ill_health = false
    as.supplementary_defined_benefit_pensions = false
  end
end

Given(/^the customer requires supplementary information about "([^"]*)"$/) do |topic|
  @appointment_summary = fixture(:populated_appointment_summary).tap do |as|
    as.supplementary_benefits = false
    as.supplementary_debt = false
    as.supplementary_ill_health = false
    as.supplementary_defined_benefit_pensions = false
  end

  case topic
  when 'Benefits and pension income' then
    @appointment_summary.supplementary_benefits = true
  when 'Debt and pensions' then
    @appointment_summary.supplementary_debt = true
  when 'Pensions and ill health' then
    @appointment_summary.supplementary_ill_health = true
  when 'Final salary or career average pensions' then
    @appointment_summary.supplementary_defined_benefit_pensions = true
  end
end

Then(/^the sections it includes should be \(in order\):$/) do |table|
  sections = table.raw.flatten

  expect(page).to include_output_document_sections(sections)
end

Then(/^it should include supplementary information about "(.*?)"$/) do |topic|
  section = case topic
            when 'Benefits and pension income' then
              'benefits'
            when 'Debt and pensions' then
              'debt'
            when 'Pensions and ill health' then
              'ill health'
            when 'Final salary or career average pensions' then
              'defined benefit pensions'
            end

  expect(page).to include_output_document_section(section)
end

Given(/^we have captured the customer's details in an appointment summary$/) do
  @appointment_summary = fixture(:populated_appointment_summary)
end

Then(/^the summary document should include their details$/) do
  output_document = OutputDocument.new(@appointment_summary)

  expect(page).to have_content(output_document.attendee_name)
end

Given(/^we have captured appointment details in an appointment summary$/) do
  @appointment_summary = fixture(:populated_appointment_summary)
end

Then(/^the summary document should include the details of the appointment$/) do
  output_document = OutputDocument.new(@appointment_summary)

  expect(page).to have_content(output_document.appointment_date)
  expect(page).to have_content(output_document.guider_first_name)
end

Then(/^details of the document should be persisted for reporting$/) do
  attributes = @appointment_summary.attributes.reject { |_, v| v.nil? }

  expect(AppointmentSummary.last).to have_attributes(attributes)
end
