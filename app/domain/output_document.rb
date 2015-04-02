class OutputDocument
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper

  attr_accessor :appointment_summary

  delegate :id, :income_in_retirement, :continue_working, :unsure,
           :leave_inheritance, :wants_flexibility, :wants_security,
           :wants_lump_sum, :poor_health,
           to: :appointment_summary

  delegate :address_line_1, :address_line_2, :address_line_3, :town, :county, :postcode,
           to: :appointment_summary, prefix: :attendee

  def initialize(appointment_summary)
    @appointment_summary = appointment_summary
  end

  def attendee_name
    "#{appointment_summary.title} #{appointment_summary.first_name} #{appointment_summary.last_name}".squish
  end

  def attendee_address
    [attendee_name,
     attendee_address_line_1,
     attendee_address_line_2,
     attendee_address_line_3,
     attendee_town,
     attendee_county,
     attendee_postcode].reject(&:blank?).map(&:squish).join("\n")
  end

  def appointment_date
    appointment_summary.date_of_appointment.to_s(:gov_uk)
  end

  def guider_organisation
    case appointment_summary.guider_organisation
    when 'cita' then 'Citizens Advice'
    when 'nicab' then 'Citizens Advice Bureau Northern Ireland'
    else 'Pension Wise'
    end
  end

  def value_of_pension_pots
    pension_pot = to_currency(appointment_summary.value_of_pension_pots)
    upper_limit = to_currency(appointment_summary.upper_value_of_pension_pots)
    is_approximate = appointment_summary.value_of_pension_pots_is_approximate?

    case
    when pension_pot.blank?   then 'No value given'
    when upper_limit.present? then "#{pension_pot} to #{upper_limit}"
    when is_approximate       then "#{pension_pot} (approximately)"
    else pension_pot
    end
  end

  def variant
    if appointment_summary.eligible_for_guidance?
      if appointment_summary.custom_guidance?
        'tailored'
      else
        'generic'
      end
    else
      'other'
    end
  end

  def lead
    "You recently had a Pension Wise guidance appointment with #{guider_first_name} " \
      "from #{guider_organisation} on #{appointment_date}."
  end

  def guider_first_name
    appointment_summary.guider_name
  end

  def pages_to_render
    case variant
    when 'tailored'
      circumstances = %i(continue_working unsure leave_inheritance
                         wants_flexibility wants_security wants_lump_sum
                         poor_health).select do |c|
        appointment_summary.public_send("#{c}?".to_sym)
      end

      [:cover_letter, :introduction, circumstances, :other_information].flatten
    when 'generic'
      %w(cover_letter introduction generic_guidance other_information)
    when 'other'
      %w(ineligible)
    end
  end

  def stylesheet(filename)
    css = Sass.compile(ERB.new(
      File.read(Rails.root.join('app', 'assets', 'stylesheets', filename))
    ).result(binding))
    "<style>\n#{css}\n</style>".html_safe
  end

  def html
    ERB.new(template).result(binding)
  end

  def pdf
    Princely.new.pdf_from_string(html)
  end

  private

  def template
    [:header, pages_to_render, :footer].flatten.reduce('') do |result, section|
      result << template_for(section) << "\n\n"
    end
  end

  def template_for(section)
    File.read(Rails.root.join('app', 'templates', "output_document_#{section}.html.erb"))
  end

  def to_currency(number)
    return '' if number.blank?

    number_to_currency(number, precision: 0)
  end
end
