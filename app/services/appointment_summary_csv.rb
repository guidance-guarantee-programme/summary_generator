# frozen_string_literal: true
class AppointmentSummaryCsv < CsvGenerator
  def attributes # rubocop: disable MethodLength
    %w(
      id
      date_of_appointment
      value_of_pension_pots
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
      organisation
    ).freeze
  end

  def row(record)
    super + [record.user.organisation_slug.upcase]
  end
end
