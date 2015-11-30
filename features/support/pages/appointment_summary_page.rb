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
  element :country, '.t-country'
  element :postcode, '.t-postcode'
  element :date_of_appointment, '.t-date-of-appointment'
  element :guider_name, '.t-guider-name'
  element :guider_organisation_nicab, '.t-guider-organisation-nicab'
  element :guider_organisation_cas, '.t-guider-organisation-cas'
  element :has_defined_contribution_pension_yes, '.t-has-defined-contribution-pension-yes'
  element :has_defined_contribution_pension_no, '.t-has-defined-contribution-pension-no'
  element :has_defined_contribution_pension_unknown, '.t-has-defined-contribution-pension-unknown'
  element :supplementary_benefits, '.t-supplementary-benefits'
  element :supplementary_debt, '.t-supplementary-debt'
  element :supplementary_ill_health, '.t-supplementary-ill-health'
  element :supplementary_defined_benefit_pensions, '.t-supplementary-defined-benefit-pensions'
  element :submit, '.t-submit'

  def fill_in(appointment_summary)
    fill_in_customer_details(appointment_summary)
    fill_in_appointment_audit_details(appointment_summary)
    fill_in_guider_details(appointment_summary)
    fill_in_has_defined_contribution_pension(appointment_summary)
    fill_in_supplementary_information(appointment_summary)
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
    country.select appointment_summary.country
    postcode.set appointment_summary.postcode
  end
  # rubocop:enable AbcSize

  def fill_in_appointment_audit_details(appointment_summary)
    date_of_appointment.set appointment_summary.date_of_appointment
  end

  def fill_in_guider_details(appointment_summary)
    guider_name.set appointment_summary.guider_name
    case appointment_summary.guider_organisation
    when 'nicab' then guider_organisation_nicab.set true
    when 'cas' then guider_organisation_cas.set true
    end
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
end
