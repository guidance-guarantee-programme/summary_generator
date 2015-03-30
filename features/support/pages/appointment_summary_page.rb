class AppointmentSummaryPage < SitePrism::Page
  set_url '/appointment_summaries/new'

  element :title, '.t-title'
  element :first_name, '.t-first-name'
  element :last_name, '.t-last-name'
  element :date_of_appointment, '.t-date-of-appointment'
  element :reference_number, '.t-reference-number'
  element :value_of_pension_pots, '.t-value-of-pension-pots'
  element :upper_value_of_pension_pots, '.t-upper-value-of-pension-pots'
  element :value_of_pension_pots_is_approximate, '.t-value-of-pension-pots-is-approximate'
  element :income_in_retirement_pension, '.t-income-in-retirement-pension'
  element :income_in_retirement_other, '.t-income-in-retirement-other'
  element :guider_name, '.t-guider-name'
  element :guider_organisation_nicab, '.t-guider-organisation-nicab'
  element :guider_organisation_cita, '.t-guider-organisation-cita'
  element :has_defined_contribution_pension_yes, '.t-has-defined-contribution-pension-yes'
  element :has_defined_contribution_pension_no, '.t-has-defined-contribution-pension-no'
  element :has_defined_contribution_pension_unknown, '.t-has-defined-contribution-pension-unknown'
  element :continue_working, '.t-continue-working'
  element :unsure, '.t-unsure'
  element :leave_inheritance, '.t-leave-inheritance'
  element :wants_flexibility, '.t-wants-flexibility'
  element :wants_security, '.t-wants-security'
  element :wants_lump_sum, '.t-wants-lump-sum'
  element :poor_health, '.t-poor-health'
  element :submit, '.t-submit'
end
