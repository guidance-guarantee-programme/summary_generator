# frozen_string_literal: true
Given(/^I am logged in as a Pension Wise analyst/) do
  create(:user, :analyst)
end

Given(/^there are existing Appointment Summaries$/) do
  create_list(
    :appointment_summary,
    Kaminari.config.default_per_page + 1
  )
end

When(/^I visit the Summary Browser$/) do
  User.first || create(:user)

  @page = AppointmentSummaryBrowserPage.new
  @page.load
end

Then(/^I am presented with Appointment Summaries$/) do
  expect(@page).to have_appointments(count: Kaminari.config.default_per_page)
end

Then(/^I see there are multiple pages$/) do
  expect(@page).to have_pages
end

Then(/^the date range is displayed$/) do
  expect(@page.start_date.value).to be_present
  expect(@page.end_date.value).to be_present
end

Then(/^I am denied access$/) do
  expect(@page).to_not be_displayed
end

When(/^I export the results to CSV$/) do
  @page.export_to_csv.click
end

Then(/^I am prompted to download a CSV$/) do
  expect(page.response_headers).to include(
    'Content-Disposition' => 'attachment; filename=data.csv',
    'Content-Type'        => 'text/csv'
  )
end
