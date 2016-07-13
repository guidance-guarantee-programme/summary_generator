# frozen_string_literal: true
class AppointmentSummaryCsv < CsvGenerator
  def attributes # rubocop: disable MethodLength
    %w(
      id
      date_of_appointment
      pension_pot_accuracy
      value_of_pension_pots
      upper_value_of_pension_pots
      guider_name
      reference_number
      address_line_1
      address_line_2
      address_line_3
      town
      county
      postcode
      country
      title
      first_name
      last_name
      format_preference
      appointment_type
      has_defined_contribution_pension
      supplementary_benefits
      supplementary_debt
      supplementary_ill_health
      supplementary_defined_benefit_pensions
      income_in_retirement
      plans_to_continue_working
      plan_is_unsure
      plans_to_leave_inheritance
      plans_for_flexibility
      plans_for_security
      plans_for_lump_sum
      plans_for_poor_health
      number_of_previous_appointments
      organisation
    ).freeze
  end

  def row(record)
    super + [record.user.organisation_slug.upcase]
  end
end
