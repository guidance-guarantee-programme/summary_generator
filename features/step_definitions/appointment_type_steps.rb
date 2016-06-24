Given(/^the customer is given the (.*?) appointment$/) do |appointment_type|
  @appointment_summary = fixture(:populated_appointment_summary).tap do |as|
    as.appointment_type = appointment_type.tr('-', '_')
  end
end

Then(/^it should be the (.*?) type of summary document$/) do |appointment_type|
  info = PDF::Reader.new(StringIO.new(@page.source)).info
  keywords = info[:Keywords].split(', ')

  expect(keywords).to include("appointment-#{appointment_type}")
end
