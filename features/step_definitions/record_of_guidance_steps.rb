When(/^appointment details are captured$/) do
  page = AppointmentSummaryPage.new
  page.load
  page.name.set 'Joe Bloggs'
  page.date_of_appointment.set '05/02/2015'
  page.value_of_pension_pots.set 35_000
  page.submit.click
end

Then(/^a record of guidance document is created$/) do
  expect(page.response_headers['Content-Type']).to eql('application/pdf')
  text = PDF::Inspector::Text.analyze(page.source).strings.join
  expect(text).to include('Joe Bloggs')
  expect(text).to include('February 5, 2015')
  expect(text).to include('£35,000')
end
