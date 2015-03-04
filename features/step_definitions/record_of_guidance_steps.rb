When(/^appointment details are captured$/) do
  page = AppointmentSummaryPage.new
  page.load
  page.name.set 'Joe Bloggs'
  page.date_of_appointment.set '05/02/2015'
  page.value_of_pension_pots.set 35_000
  page.income_in_retirement_pension.set true
  page.guider_name.set 'Alex Leahy'
  page.guider_organisation_tpas.set true
  page.continue_working.set true
  page.unsure.set true
  page.leave_inheritance.set true
  page.wants_flexibility.set true
  page.wants_security.set true
  page.wants_lump_sum.set true
  page.poor_health.set true
  page.submit.click
end

Then(/^a record of guidance document is created$/) do
  expect(page.response_headers['Content-Type']).to eql('application/pdf')
  text = PDF::Inspector::Text.analyze(page.source).strings.join
  expect(text).to include('Joe Bloggs')
  expect(text).to include('February 5, 2015')
  expect(text).to include('£35,000')
end
