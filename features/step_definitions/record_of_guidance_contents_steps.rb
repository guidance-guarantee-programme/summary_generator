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

Given(/^the customer has access to income during retirement from (.*?)$/) do |sources_of_income|
  @appointment_summary = fixture(:populated_appointment_summary).tap do |as|
    as.income_in_retirement = case sources_of_income
                              when 'only their DC pot and state pension' then 'pension'
                              when 'multiple sources'                    then 'other'
                              end
  end
end

Then(/^the "pension pot" section should be the "(.*?)" version$/) do |version|
  version = case version
            when 'only their DC pot and state pension' then 'pension'
            when 'multiple sources'                    then 'other'
            end

  expect(page).to include_output_document_section('pension pot').at_version(version)
end

Given(/^we have captured the customer's details in an appointment summary$/) do
  @appointment_summary = fixture(:populated_appointment_summary)
end

Then(/^the record of guidance should include their details$/) do
  output_document = OutputDocument.new(@appointment_summary)

  expect(page).to have_content(output_document.attendee_name)
  expect(page).to have_content(output_document.value_of_pension_pots)
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
