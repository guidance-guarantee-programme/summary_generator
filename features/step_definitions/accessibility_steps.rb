Given(/^the customer prefers to receive their summary document in (.*?) format$/) do |format_preference|
  @appointment_summary = fixture(:populated_appointment_summary).tap do |as|
    as.format_preference = format_preference.gsub(/\s+/, '_')
  end
end

Then(/^it should be in (.*) format$/) do |format_preference|
  step 'I have previewed the output document'
  step 'I confirm the preview'

  info = PDF::Reader.new(StringIO.new(page.source)).info

  expect(info).to include(Keywords: format_preference)
end
