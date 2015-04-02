class AppointmentSummaryPage < SitePrism::Page
  set_url '/appointment_summaries/new'

  element :title, '.t-title'
  element :first_name, '.t-first-name'
  element :last_name, '.t-last-name'
  element :address_line_1, '.t-address-line-1'
  element :address_line_2, '.t-address-line-2'
  element :address_line_3, '.t-address-line-3'
  element :town, '.t-town'
  element :county, '.t-county'
  element :postcode, '.t-postcode'
  element :date_of_appointment, '.t-date-of-appointment'
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

  def fill_in(appointment_summary)
    fill_in_customer_details(appointment_summary)
    fill_in_appointment_audit_details(appointment_summary)
    fill_in_pension_pot_details(appointment_summary)
    fill_in_income_in_retirement_details(appointment_summary)
    fill_in_guider_details(appointment_summary)
    fill_in_has_defined_contribution_pension(appointment_summary)
    fill_in_circumstances(appointment_summary)
  end

  private

  # rubocop:disable AbcSize
  def fill_in_customer_details(appointment_summary)
    title.select appointment_summary.title
    first_name.set appointment_summary.first_name
    last_name.set appointment_summary.last_name
    address_line_1.set appointment_summary.address_line_1
    address_line_2.set appointment_summary.address_line_2
    address_line_3.set appointment_summary.address_line_3
    town.set appointment_summary.town
    county.set appointment_summary.county
    postcode.set appointment_summary.postcode
  end
  # rubocop:enable AbcSize

  def fill_in_appointment_audit_details(appointment_summary)
    date_of_appointment.set appointment_summary.date_of_appointment
  end

  def fill_in_pension_pot_details(appointment_summary)
    value_of_pension_pots.set appointment_summary.value_of_pension_pots
    upper_value_of_pension_pots.set appointment_summary.upper_value_of_pension_pots
    value_of_pension_pots_is_approximate.set appointment_summary.value_of_pension_pots_is_approximate?
  end

  def fill_in_income_in_retirement_details(appointment_summary)
    case appointment_summary.income_in_retirement
    when 'pension' then income_in_retirement_pension.set true
    when 'other' then income_in_retirement_other.set true
    end
  end

  def fill_in_guider_details(appointment_summary)
    guider_name.set appointment_summary.guider_name
    case appointment_summary.guider_organisation
    when 'nicab' then guider_organisation_nicab.set true
    when 'cita' then guider_organisation_cita.set true
    end
  end

  def fill_in_has_defined_contribution_pension(appointment_summary)
    case appointment_summary.has_defined_contribution_pension
    when 'yes' then has_defined_contribution_pension_yes.set true
    when 'no' then has_defined_contribution_pension_no.set true
    when 'unknown' then has_defined_contribution_pension_unknown.set true
    end
  end

  # rubocop:disable AbcSize
  def fill_in_circumstances(appointment_summary)
    continue_working.set appointment_summary.continue_working?
    unsure.set appointment_summary.unsure?
    leave_inheritance.set appointment_summary.leave_inheritance?
    wants_flexibility.set appointment_summary.wants_flexibility?
    wants_security.set appointment_summary.wants_security?
    wants_lump_sum.set appointment_summary.wants_lump_sum?
    poor_health.set appointment_summary.poor_health?
  end
  # rubocop:enable AbcSize
end
