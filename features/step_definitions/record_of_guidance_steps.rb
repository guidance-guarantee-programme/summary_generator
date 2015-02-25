When(/^appointment details are captured$/) do
  page = AppointmentSummaryPage.new
  page.load
  page.name.set 'Joe Bloggs'
  page.submit.click
end
