Given(/^the customer prefers to receive their summary document in (.*?) format$/) do |format_preference|
  @appointment_summary = fixture(:populated_appointment_summary).tap do |as|
    as.format_preference = format_preference.gsub(/\s+/, '_')
  end
end

Then(/^it should be in (.*) format$/) do |format_preference|
  page = RecordOfGuidancePreviewPage.new
  page.confirm.click

  info = PDF::Reader.new(StringIO.new(page.source)).info
  keywords = info[:Keywords].split(', ')

  expect(keywords).to include(format_preference)
end
