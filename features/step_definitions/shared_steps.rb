# frozen_string_literal: true
Given(/^a customer has had a Pension Wise appointment$/) do
  @appointment_summary = fixture(:populated_appointment_summary)
end

When(/^we preview their summary document$/) do
  User.create

  page = AppointmentSummaryPage.new
  page.load
  page.fill_in(@appointment_summary)
  page.submit.click
end

When(/^we generate their summary document$/) do
  User.create

  page = AppointmentSummaryPage.new
  page.load
  page.fill_in(@appointment_summary)
  page.submit.click

  @page = RecordOfGuidancePreviewPage.new
  @page.confirm.click
end
