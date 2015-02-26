When(/^appointment details are captured$/) do
  page = AppointmentSummaryPage.new
  page.load
  page.name.set 'Joe Bloggs'
  page.submit.click
end

Then(/^a record of guidance document is created$/) do
  expect(page.response_headers['Content-Type']).to eql('application/pdf')
  text = PDF::Inspector::Text.analyze(page.source).strings.join
  expect(text).to include('Joe Bloggs')
end
