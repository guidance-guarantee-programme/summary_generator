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
                    .map { |s| "<!-- section: #{s}" }
                    .map { |s| page.source.index(s) }

  expect(section_indexes.sort).to eq(section_indexes)
end

Given(/^"(.*?)" applies to the customer$/) do |circumstance|
  @appointment_summary = fixture(:populated_appointment_summary).tap do |as|
    as.continue_working = false
    as.unsure = false
    as.leave_inheritance = false
    as.wants_flexibility = false
    as.wants_security = false
    as.wants_lump_sum = false
    as.poor_health = false
  end

  case circumstance
  when 'Plans to continue working for a while' then @appointment_summary.continue_working = true
  when 'Unsure about plans in retirement'      then @appointment_summary.unsure = true
  when 'Plans to leave money to someone'       then @appointment_summary.leave_inheritance = true
  when 'Wants flexibility when taking money'   then @appointment_summary.wants_flexibility = true
  when 'Wants a guaranteed income'             then @appointment_summary.wants_security = true
  when 'Needs a certain amount of money now'   then @appointment_summary.wants_lump_sum = true
  when 'Has poor health'                       then @appointment_summary.poor_health = true
  end
end

Then(/^it should include information about "(.*?)"$/) do |circumstance|
  section = case circumstance
            when 'Plans to continue working for a while' then '<!-- section: continue working -->'
            when 'Unsure about plans in retirement'      then '<!-- section: unsure -->'
            when 'Plans to leave money to someone'       then '<!-- section: leave inheritance -->'
            when 'Wants flexibility when taking money'   then '<!-- section: wants flexibility -->'
            when 'Wants a guaranteed income'             then '<!-- section: wants security -->'
            when 'Needs a certain amount of money now'   then '<!-- section: wants lump sum -->'
            when 'Has poor health'                       then '<!-- section: poor health -->'
            end

  expect(page.source).to include(section)
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

  section_identifier = '<!-- section: pension pot'
  expect(page.source.scan(/#{section_identifier}/).count).to eq(1)
  expect(page.source).to include("#{section_identifier}, version: #{version} -->")
end

Given(/^we have captured the customer's details in an appointment summary$/) do
  @appointment_summary = fixture(:populated_appointment_summary)
end

Then(/^the record of guidance should include their details$/) do
  output_document = OutputDocument.new(@appointment_summary)

  expect(page).to have_content(output_document.attendee_name)
  expect(page).to have_content(output_document.value_of_pension_pots)
end
