Given(/^one or more of the predefined circumstances applies to the customer$/) do
  @appointment_summary = fixture(:populated_appointment_summary).tap do |as|
    as.continue_working = true
    as.unsure = false
    as.leave_inheritance = true
    as.wants_flexibility = false
    as.wants_security = true
    as.wants_lump_sum = false
    as.poor_health = true
  end
end

Given(/^we don't know that any of the predefined circumstances apply to the customer$/) do
  @appointment_summary = fixture(:populated_appointment_summary).tap do |as|
    as.continue_working = false
    as.unsure = false
    as.leave_inheritance = false
    as.wants_flexibility = false
    as.wants_security = false
    as.wants_lump_sum = false
    as.poor_health = false
  end
end

When(/^we send them their record of guidance$/) do
  page = AppointmentSummaryPage.new
  page.load
  page.fill_in(@appointment_summary)
  page.submit.click
end

Then(/^the sections it includes should be \(in order\):$/) do |table|
  sections = table.raw.flatten

  if (index = sections.index('detail about applicable circumstances'))
    circumstances = []
    circumstances << 'continue working' if @appointment_summary.continue_working?
    circumstances << 'unsure' if @appointment_summary.unsure?
    circumstances << 'leave inheritance' if @appointment_summary.leave_inheritance?
    circumstances << 'wants flexibility' if @appointment_summary.wants_flexibility?
    circumstances << 'wants security' if @appointment_summary.wants_security?
    circumstances << 'wants lump sum' if @appointment_summary.wants_lump_sum?
    circumstances << 'poor health' if @appointment_summary.poor_health?

    sections[index] = circumstances
    sections.flatten!
  end

  section_indexes = sections
                    .map { |s| "<!-- section: #{s} -->" }
                    .map { |s| page.source.index(s) }

  expect(section_indexes.sort).to eq(section_indexes)
end

# rubocop:disable UnusedBlockArgument
Given(/^"(.*?)" applies to the customer$/) do |circumstance|
  pending
end

Then(/^it should include information about "(.*?)"$/) do |circumstance|
  pending
end

Given(/^the customer has access to income during retirement from "(.*?)"$/) do |sources_of_income|
  pending
end

Then(/^the "pension-pot" section should be the "(.*?)" version$/) do |version|
  pending
end

Given(/^we have captured the customer's details in an appointment summary$/) do
  pending
end

Then(/^the record of guidance should include their details$/) do
  pending
end
# rubocop:enable UnusedBlockArgument
