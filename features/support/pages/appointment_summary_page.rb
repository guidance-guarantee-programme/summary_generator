require_relative '../site_prism/radio_button_container'

class AppointmentSummaryPage < SitePrism::Page # rubocop:disable ClassLength
  extend SitePrism::RadioButtonContainer

  set_url '/appointment_summaries/new'

  element :title, '.t-title'
  element :first_name, '.t-first-name'
  element :last_name, '.t-last-name'
  element :address_line_1, '.t-address-line-1'
  element :address_line_2, '.t-address-line-2'
  element :address_line_3, '.t-address-line-3'
  element :town, '.t-town'
  element :county, '.t-county'
  element :country, '.t-country'
  element :postcode, '.t-postcode'
  element :date_of_appointment, '.t-date-of-appointment'
  element :guider_name, '.t-guider-name'
  element :has_defined_contribution_pension_yes, '.t-has-defined-contribution-pension-yes'
  element :has_defined_contribution_pension_no, '.t-has-defined-contribution-pension-no'
  element :has_defined_contribution_pension_unknown, '.t-has-defined-contribution-pension-unknown'
  element :supplementary_benefits, '.t-supplementary-benefits'
  element :supplementary_debt, '.t-supplementary-debt'
  element :supplementary_ill_health, '.t-supplementary-ill-health'
  element :supplementary_defined_benefit_pensions, '.t-supplementary-defined-benefit-pensions'
  element :submit, '.t-submit'
  element :value_of_pension_pots, '.t-value-of-pension-pots'
  element :upper_value_of_pension_pots, '.t-upper-value-of-pension-pots'
  element :value_of_pension_pots_is_approximate, '.t-value-of-pension-pots-is-approximate'
  element :income_in_retirement, '.t-income-in-retirement'
  element :plans_to_continue_working, '.t-plans-to-continue-working'
  element :plan_is_unsure, '.t-plan-is-unsure'
  element :plans_to_leave_inheritance, '.t-plans-to-leave-inheritance'
  element :plans_for_flexibility, '.t-plans-for-flexibility'
  element :plans_for_security, '.t-plans-for-security'
  element :plans_for_lump_sum, '.t-plans-for-lump-sum'
  element :plans_for_poor_health, '.t-plans-for-poor-health'
  element :reference_number, '.t-reference-number'

  radio_buttons :pension_pot_accuracy,
                exact: '.t-pension-pot-accuracy-exact'

  radio_buttons :income_in_retirement,
                pension: '.t-income-in-retirement-pension'

  radio_buttons :format_preference,
                standard: '.t-format-preference-standard',
                large_text: '.t-format-preference-large-text'

  radio_buttons :appointment_type,
                standard: '.t-appointment-type-standard',
                appointment_50_54: '.t-appointment-type-50-54'

  def fill_in(appointment_summary)
    fill_in_customer_details(appointment_summary)
    fill_in_appointment_audit_details(appointment_summary)
    fill_in_guider_details(appointment_summary)
    fill_in_has_defined_contribution_pension(appointment_summary)
    fill_in_supplementary_information(appointment_summary)
    fill_in_format_preference(appointment_summary)
    fill_in_appointment_type(appointment_summary)
    fill_in_pension_pot_details(appointment_summary)
  end

  private

  def fill_in_customer_details(appointment_summary) # rubocop:disable AbcSize
    title.select appointment_summary.title
    first_name.set appointment_summary.first_name
    last_name.set appointment_summary.last_name
    address_line_1.set appointment_summary.address_line_1
    address_line_2.set appointment_summary.address_line_2
    address_line_3.set appointment_summary.address_line_3
    town.set appointment_summary.town
    county.set appointment_summary.county
    country.select appointment_summary.country
    postcode.set appointment_summary.postcode
  end

  def fill_in_appointment_audit_details(appointment_summary)
    date_of_appointment.set appointment_summary.date_of_appointment
    reference_number.set appointment_summary.reference_number
  end

  def fill_in_guider_details(appointment_summary)
    guider_name.set appointment_summary.guider_name
  end

  def fill_in_has_defined_contribution_pension(appointment_summary)
    case appointment_summary.has_defined_contribution_pension
    when 'yes' then has_defined_contribution_pension_yes.set true
    when 'no' then has_defined_contribution_pension_no.set true
    when 'unknown' then has_defined_contribution_pension_unknown.set true
    end
  end

  def fill_in_supplementary_information(appointment_summary)
    supplementary_benefits.set appointment_summary.supplementary_benefits
    supplementary_debt.set appointment_summary.supplementary_debt
    supplementary_ill_health.set appointment_summary.supplementary_ill_health
    supplementary_defined_benefit_pensions.set appointment_summary.supplementary_defined_benefit_pensions
  end

  def fill_in_format_preference(appointment_summary)
    case appointment_summary.format_preference
    when 'standard' then format_preference_standard.set true
    when 'large_text' then format_preference_large_text.set true
    end
  end

  def fill_in_appointment_type(appointment_summary)
    case appointment_summary.appointment_type
    when 'standard' then appointment_type_standard.set true
    when '50_54' then appointment_type_appointment_50_54.set true
    end
  end

  def fill_in_pension_pot_details(appointment_summary) # rubocop:disable AbcSize
    value_of_pension_pots.set(appointment_summary.value_of_pension_pots)
    upper_value_of_pension_pots.set(appointment_summary.upper_value_of_pension_pots)
    send("pension_pot_accuracy_#{appointment_summary.pension_pot_accuracy}").set true
    send("income_in_retirement_#{appointment_summary.income_in_retirement}").set true
    plans_to_continue_working.set appointment_summary.plans_to_continue_working
    plan_is_unsure.set appointment_summary.plan_is_unsure
    plans_to_leave_inheritance.set appointment_summary.plans_to_leave_inheritance
    plans_for_flexibility.set appointment_summary.plans_for_flexibility
    plans_for_security.set appointment_summary.plans_for_security
    plans_for_lump_sum.set appointment_summary.plans_for_lump_sum
    plans_for_poor_health.set appointment_summary.plans_for_poor_health
  end
end
