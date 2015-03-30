When(/^appointment details are captured$/) do
  page = AppointmentSummaryPage.new
  page.load
  page.title.select 'Mr'
  page.first_name.set 'Joe'
  page.last_name.set 'Bloggs'
  page.date_of_appointment.set '05/02/2015'
  page.value_of_pension_pots.set 35_000
  page.upper_value_of_pension_pots.set 55_000
  page.value_of_pension_pots_is_approximate.set true
  page.income_in_retirement_pension.set true
  page.guider_name.set 'Alex Leahy'
  page.guider_organisation_cita.set true
  page.has_defined_contribution_pension_yes.set true
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
  expect(text).to match(/February 5, ?2015/) # this is showing up as "February 5,2015" on Travis
  expect(text).to include('£35,000')
end
